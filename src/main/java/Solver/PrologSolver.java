package Solver;

import Traducteur.Parser;
import org.apache.commons.io.IOUtils;
import org.jpl7.*;
import org.jpl7.Integer; // Important: garder l'import de jpl7 pour la compatibilité

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

// CHANGEMENT : Renommage et implémentation de l'interface
public class PrologSolver implements SolverInterface {

    // --- CHAMPS DE LA CLASSE (INCHANGÉS) ---
    private String provenanceGraphPath;
    private String timeDataPath;
    private List<Issue> issues;
    private List<String> personalData;
    private List<String> users;
    private List<String> process;
    private final Set<String> filesLoad = new HashSet<>();
    private final Set<String> predicatesLoad = new HashSet<>();

    // --- CONSTRUCTEURS (INCHANGÉS) ---
    public PrologSolver(String provenanceGraphPath, String timeDataPath, List<String> queries) throws IOException {
        setProvenanceGraphPath(provenanceGraphPath);
        this.timeDataPath = timeDataPath; // setTimeFilePath est privé maintenant
    }
    public PrologSolver() {}

    // --- SETTERS (certains deviennent privés ou sont moins utilisés) ---
    public void setProvenanceGraphPath(String provenanceGraphPath) throws IOException {
        this.provenanceGraphPath = provenanceGraphPath;
        Parser parser = new Parser(new File(provenanceGraphPath));
        this.personalData = parser.parserData();
        this.users = parser.parserUser();
        this.process = parser.parserProcess();
    }
    private void setTimeFilePath(String timeDataPath){
        this.timeDataPath = timeDataPath;
    }

    // --- MÉTHODE SOLVE ADAPTÉE ---
    @Override
    public String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException {
        // Initialisation des variables pour cette exécution spécifique
        setProvenanceGraphPath(provenanceGraphPath);
        setTimeFilePath(timeDataPath);
        this.issues = new ArrayList<>(); // resetStoredIssues()

        // Chargement des fichiers Prolog nécessaires
        loadResource("/RGPD/causal_dependencies.pl");
        loadTimeTerms();
        loadPrologFile(this.provenanceGraphPath);

        // Utilisation d'un StringBuilder pour un code plus propre
        StringBuilder resultBuilder = new StringBuilder();

        // On réinitialise le compteur d'ID statique de la classe Issue
        // Issue.resetCounter(); // Vous pourriez ajouter une méthode statique pour cela dans Issue

        for (String principleName : principles) {
            Issue.IssueType issueType = Issue.IssueType.fromString(principleName);
            String prologQuery = getPrologQueryForPrinciple(issueType);

            // --- CORRECTION ICI ---
            // On mappe le nom du type d'issue au nom de fichier réel.
            String fileName = switch (issueType) {
                case RIGHT_TO_ERASURE -> "erase_compliant.pl";
                case RIGHT_TO_ACCESS -> "right_access.pl";
                case STORAGE_LIMITATION -> "storage_limitation.pl";
                case LEGAL -> "legal.pl";
                default -> "";
            };

            if (!fileName.isEmpty()) {
                try {
                    loadResource("/RGPD/" + fileName);
                } catch (IOException e) {
                    System.err.println("Warning: Could not load rule file: " + fileName);
                    continue; // On passe au principe suivant si le fichier n'est pas trouvé
                }
            }
            // --- CHANGEMENT : LE BLOC DE DÉBOGAGE EST MAINTENANT SANS CONDITION ---
            System.out.println("====================================================================");
            System.out.println(">>> ACTIVATION DU TRACEUR PROLOG pour le principe : " + issueType.name());
            System.out.println("====================================================================");
            new Query("leash(-all)").hasSolution();
            new Query("trace").hasSolution();
            try {
                Query q = new Query(prologQuery);
                if (q.hasSolution()) {
                    HashMap<String, Term>[] solutions = (HashMap<String, Term>[]) q.allSolutions();
                    for (HashMap<String, Term> sol : solutions) {
                        // CHANGEMENT : On utilise le constructeur Prolog de la nouvelle classe Issue
                        Issue issue = new Issue(issueType.typeName, sol);
                        this.issues.add(issue);
                        resultBuilder.append(issue.toString());
                    }
                }
            } catch (PrologException e) {
                System.err.println("Prolog error during query for principle '" + principleName + "': " + e.getMessage());
            }
        }

        resetSolver(); // Nettoyage de l'environnement Prolog

        String finalResult = resultBuilder.toString();
        return finalResult.isEmpty() ? "System is compliant." : finalResult;
    }

    // --- AUTRES MÉTHODES PUBLIQUES DE L'INTERFACE ---
    @Override
    public List<Issue> getIssues() {
        return issues;
    }

    // --- MÉTHODES UTILITAIRES PRIVÉES ---

    private String getPrologQueryForPrinciple(Issue.IssueType type) {
        return switch (type) {
            case LEGAL -> "legal(P, D, PU, T, DP, C).";
            case RIGHT_TO_ERASURE -> "eraseCompliant(D, T, P).";
            case RIGHT_TO_ACCESS -> "rightAccess(S, TE).";
            case STORAGE_LIMITATION -> "storageLimitation(D, TU).";
            default -> "true.";
        };
    }

    // --- VOS MÉTHODES PROLOG UTILS EXISTANTES (INCHANGÉES) ---
    void loadTermsFromList(List<Term> terms){
        for (Term t : terms){
            Term assertTerm = Term.textToTerm("assertz(" + t.toString() + ")");
            Query q = new Query(assertTerm);
            q.hasSolution();
            predicatesLoad.add(t.name() + "/" + t.arity());
        }
    }

    void unloadAllPredicates(){
        for (String predicate : predicatesLoad){
            Query q = new Query("abolish(" + predicate + ")");
            q.hasSolution();
        }
        predicatesLoad.clear();
    }

    void loadPrologFile(String path) throws IOException{
        Query pred = new Query("consult", new Term[] {new Atom(path)});
        if (!pred.hasSolution()){ throw new IOException("error opening " + path); }
        else{ filesLoad.add(path); }
    }

    void loadResource(String resource) throws IOException {
        String resourceDirs = "." + resource.substring(0,resource.lastIndexOf("/"));
        new File(resourceDirs).mkdirs();
        File resourceFile = new File("." +resource+"-copy");
        if(!resourceFile.exists()) resourceFile.createNewFile();
        InputStream resourceStream = getClass().getResourceAsStream(resource);
        if (resourceStream == null) throw new IOException("Resource not found: " + resource);
        try (OutputStream out = new FileOutputStream(resourceFile.getPath())) {
            IOUtils.copy(resourceStream, out);
        }
        String path = resourceFile.getPath();
        Query pred = new Query("consult", new Term[] {new Atom(path)});
        if (!pred.hasSolution()){ throw new IOException("error opening " + path); }
        else{ filesLoad.add(path); }
    }

    void unloadAllFiles() throws RuntimeException {
        for (String path : filesLoad){
            Query pred = new Query("unload_file", new Term[] {new Atom(path)});
            if (!pred.hasSolution()){
                // Ne pas lancer d'exception si le fichier est déjà déchargé, c'est moins strict
                // throw new RuntimeException("error closing " + path);
            }
        }
        filesLoad.clear();
    }

    void resetSolver(){
        // unloadAllPredicates(); // 'abolish' peut être problématique, le déchargement de fichier est souvent suffisant
        unloadAllFiles();
    }

    void loadTimeTerms() throws IOException {
        loadPrologFile(timeDataPath);
    }
}
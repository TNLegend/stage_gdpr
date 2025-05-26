package Solver;

import Traducteur.Parser;
import org.apache.commons.io.IOUtils;
import org.jpl7.*;
import org.jpl7.Integer;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

public class Solver {
    private String provenanceGraphPath;
    private String timeDataPath;
    private List<String> queries;
    private int tCurrent;
    private int tLimitAccess;
    private int tLimitErase;
    private int tLimitStorage;
    private List<String> personalData; // List of every personal data found in the provenance graph. Given by Parser
    private List<String> users; // List of every user found in the provenance graph. Given by Parser
    private List<String> process; // List of every process found in the provenance graph. Given by Parser

    private List<Issue> issues;

    private final Set<String> filesLoad = new HashSet<>();
    private final Set<String> predicatesLoad = new HashSet<>();

    /**
     * Initialises the src.main.java.Solver by setting required variables.
     * @param provenanceGraphPath Path to the Prolog file representing the provenance graph
     * @param timeDataPath Path to the Prolog file containing time data information
     * @param queries List of queries to submit
     * @throws IOException If provenance graph could not be opened
     */
    public Solver(String provenanceGraphPath, String timeDataPath, List<String> queries) throws IOException {
        setProvenanceGraphPath(provenanceGraphPath);
        setTimeFilePath(timeDataPath);
        this.queries = queries;
    }

    /**
     * Base constructor.
     */
    public Solver() {
    }

    /**
     * Update the current provenance graph path. The method also retrieves personal data, users and process of the system
     * @param provenanceGraphPath Path to the Prolog file representing the provenance graph
     * @throws IOException If an error occurs when opening the file
     */
    public void setProvenanceGraphPath(String provenanceGraphPath) throws IOException {
       
        this.provenanceGraphPath = provenanceGraphPath;
        Parser parser = new Parser(new File(provenanceGraphPath));
        this.personalData = parser.parserData();
        this.users = parser.parserUser();
        this.process = parser.parserProcess();
    }

    public void setTimeFilePath(String timeDataPath){
        this.timeDataPath = timeDataPath;
    }

    public void setQueries(List<String> queries){
        this.queries = queries;
    }

    public void setCurrentTime(int tCurrent) {
        this.tCurrent = tCurrent;
    }

    public void setAccessTimeLimit(int tLimitAccess) {
        this.tLimitAccess = tLimitAccess;
    }

    public void setEraseTimeLimit(int tLimitErase) {
        this.tLimitErase = tLimitErase;
    }

    public void setStorageTimeLimit(int tLimitStorage) {
        this.tLimitStorage = tLimitStorage;
    }

    // ------------------------------ PROLOG UTILS ------------------------------ //

    /**
     * Loads a list of terms to the Prolog solver
     * @param terms String List containing the terms to load
     */
    void loadTermsFromList(List<Term> terms){
        for (Term t : terms){
            Term assertTerm = Term.textToTerm("assertz(" + t.toString() + ")");
            Query q = new Query(assertTerm);
            q.hasSolution();
            predicatesLoad.add(t.name() + "/" + t.arity());
        }
    }

    /**
     * Unloads all previously load predicates from the Prolog solver. It prevents errors for next solver calls.
     */
    void unloadAllPredicates(){
        for (String predicate : predicatesLoad){
            Query q = new Query("abolish(" + predicate + ")");
            q.hasSolution();
        }
        predicatesLoad.clear();
    }

    /**
     * Loads content from a file into the Prolog solver
     * @param path Path to the file to load
     * @throws IOException If an error occurs when opening the file
     */
    void loadPrologFile(String path) throws IOException{
        Query pred = new Query(
                "consult",
                new Term[] {new Atom(path)}
        );
        if (!pred.hasSolution()){
            throw new IOException("error opening " + path);
        }
        else{
            filesLoad.add(path);
        }
    }

    void loadResource(String resource) throws IOException {
        String resourceDirs = "." + resource.substring(0,resource.lastIndexOf("/"));
        new File(resourceDirs).mkdirs();  //Create resource copy directory if absent

        File resourceFile = new File("." +resource+"-copy");
        if(!resourceFile.exists())  resourceFile.createNewFile();

        InputStream resourceStream = Solver.class.getResourceAsStream(resource);  //Cannot get the file directly due to jar file structure
        OutputStream out = new FileOutputStream(resourceFile.getPath());
        IOUtils.copy(resourceStream, out);
        String path = resourceFile.getPath();

        Query pred = new Query(
                "consult",
                new Term[] {new Atom(path.toString())}
        );

        if (!pred.hasSolution()){
            throw new IOException("error opening " + path);
        }
        else{
            filesLoad.add(path.toString());
        }
    }

    /**
     * Unloads all previously load files from the Prolog solver. It prevents errors for next solver calls.
     * @throws RuntimeException If an error occurs when closing a file
     */
    void unloadAllFiles() throws RuntimeException {
        for (String path : filesLoad){
            Query pred = new Query(
                    "unload_file",
                    new Term[] {new Atom(path)}
            );
            if (!pred.hasSolution()){
                throw new RuntimeException("error closing " + path);
            }
        }
        filesLoad.clear();
    }

    /**
     * Prepares the solver for the next verification.
     */
    void resetSolver(){
        unloadAllPredicates();
        unloadAllFiles();
    }

    /**
     * Prepares the solver variables for the next verification.
     */
    void resetStoredIssues(){
        issues = new ArrayList<>();
    }

    // ------------------------------ RGPD UTILS ------------------------------ //

    /**
     * Builds a list containing Prolog facts required to check current time and time limits.
     * @return List of terms associating time variables with their values
     */
    private List<Term> buildTimeTerms(){
        List<Term> terms = new ArrayList<>();
        terms.add(new Compound("tCurrent", new Term[]{new Integer(tCurrent)}));
        terms.add(new Compound("tLimit", new Term[]{new Atom("access"), new Integer(tLimitAccess)}));
        terms.add(new Compound("tLimit", new Term[]{new Atom("erase"), new Integer(tLimitErase)}));
        terms.add(new Compound("tLimit", new Term[]{new Atom("storage"), new Integer(tLimitStorage)}));
        return terms;
    }

    /**
     * Loads all time terms to the Prolog solver
     */
    void loadTimeTerms() throws IOException {
        loadPrologFile(timeDataPath);
    }

    void openNewStream(){
        Query open = new Query("open('compliance_results.txt', write, Fd, [alias(stream)])");
        open.hasSolution();

        Query setOutput = new Query("set_output(stream)");
        setOutput.hasSolution();
    }

    String getResults() throws IOException {
        File results = new File("./compliance_results.txt");
        String resultString = Files.readString(Path.of(results.getAbsolutePath()));
        if(resultString.isEmpty()) resultString = "System is compliant.";
        return resultString;
    }


    // ------------------------------ SOLVER ------------------------------ //

    /**
     * Verifies given queries and outputs observations in console.
     */
    public String solve() throws IOException {

        resetStoredIssues();

        loadResource("/RGPD/causal_dependencies.pl");
        loadTimeTerms();


        File results = new File("./compliance_results.txt");
        FileWriter fw = new FileWriter(results);
        BufferedWriter bw = new BufferedWriter(fw);

        loadPrologFile(provenanceGraphPath);
        // openNewStream();

        Issue.GLOBAL_ID = 1;

        for (String s : queries){
            if (personalData.isEmpty()){
                bw.write("WARNING - no personal data in provenance graph\n");
            }

            if (s.startsWith("legal")){
                try{
                    new Query("used(P,A,R,T)").hasSolution();
                }
                catch (PrologException e){
                    bw.write("WARNING - could not check " + s + " as there is no use of any personal data\n");
                    continue;
                }

                loadResource("/RGPD/legal.pl");

                try{
                    Query q = new Query(s);
                    HashMap<String, Term>[] consentIssues = (HashMap<String, Term>[]) q.allSolutions();

                    for (HashMap<String,Term> sol : consentIssues){
                        Issue issue = new Issue("legal", sol);
                        issues.add(issue);
                        bw.write(issue.toString());
                    }
                } catch (PrologException e){
                    bw.write("CONSENT ISSUE - consent not compliant as no consent was given\n");
                    continue;
                }

            } else if (s.startsWith("rightAccess")){
                try {
                    new Query("wasControlledBy(P,S,R,TB,TE)").hasSolution();
                } catch (PrologException e){
                    bw.write("WARNING - could not check " + s + " as there is no access request\n");
                    continue;
                }

                loadResource("/RGPD/right_access.pl");

                Query q = new Query(s);
                HashMap<String, Term>[] accessIssues = (HashMap<String, Term>[]) q.allSolutions();

                for (HashMap<String,Term> sol : accessIssues){
                    Issue issue = new Issue("rightAccess", sol);
                    issues.add(issue);
                    bw.write(issue.toString());
                }

            } else if (s.startsWith("eraseCompliant")) {
                try{
                    new Query("used(P,A,R,T)").hasSolution();
                } catch (PrologException e){
                    bw.write("WARNING - could not check " + s + " as there is no erase request (no process in provenance graph)\n");
                    continue;
                }
                loadResource("/RGPD/erase_compliant.pl");

                Query q = new Query(s);
                HashMap<String, Term>[] eraseIssues = (HashMap<String, Term>[]) q.allSolutions();

                for (HashMap<String,Term> sol : eraseIssues){
                    Issue issue = new Issue("eraseCompliant", sol);
                    issues.add(issue);
                    bw.write(issue.toString());
                }


            } else if (s.startsWith("storageLimitation")) {
                try{
                    new Query("used(P,A,R,T)").hasSolution();
                }
                catch (PrologException e){
                    bw.write("WARNING - could not check " + s + " as no personal data was used\n");
                    continue;
                }
                loadResource("/RGPD/storage_limitation.pl");

                Query q = new Query(s);
                HashMap<String, Term>[] storageIssues = (HashMap<String, Term>[]) q.allSolutions();

                for (HashMap<String,Term> sol : storageIssues){
                    Issue issue = new Issue("storageLimitation", sol);
                    issues.add(issue);
                    bw.write(issue.toString());
                }


            }
        }

        bw.close();
        fw.close();

        resetSolver();

        return getResults();
    }

    // ------------------------------ CYPHER UTILS ------------------------------ //


    public List<Issue> getIssues(){
        return issues;
    }
}

package Solver;

import Traducteur.Parser;
import org.apache.commons.io.IOUtils;
import org.jpl7.*;

import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Prolog-side solver that loads the rule files and provenance graph,
 * runs the four GDPR predicates, and collects Issue facts.
 *
 * This version:
 *  - Avoids JPL stream-blob issues by using with_output_to(atom(_), ...) in the silencer.
 *  - Silences SWI-Prolog "discontiguous"/"singleton" warnings at runtime (no edits to .pl files).
 *  - Prints PROLOG time info (values + clause sources) to compare with Cypher.
 */
public class PrologSolver implements SolverInterface {

    private static final boolean PROLOG_TRACING_ENABLED_FOR_DEBUG = false;

    private String provenanceGraphPath;
    private String timeDataPath;
    private List<Issue> issues;
    private List<String> personalData;
    private List<String> users;
    private List<String> process;

    private final Set<String> filesLoad = new HashSet<>();
    private final Set<String> predicatesLoad = new HashSet<>();

    private static final Set<String> VALID_PREDICATES =
            Set.of("legal", "eraseCompliant", "rightAccess", "storageLimitation");

    // Cache to avoid double logging of defaults per graph
    private static final Set<String> prologDefaultsLoggedForGraph =
            Collections.synchronizedSet(new HashSet<>());

    public PrologSolver(String provenanceGraphPath, String timeDataPath, List<String> queries) throws IOException {
        setProvenanceGraphPath(provenanceGraphPath);
        this.timeDataPath = timeDataPath;
    }

    public PrologSolver() {}

    /**
     * Wrap a Prolog goal so writes to stdout/stderr are discarded, without creating stream blobs.
     * We use with_output_to(atom(_), ...) which is widely supported and blob-free.
     */
    private static String silentWrap(String goal) {
        String core = goal.trim();
        if (core.endsWith(".")) core = core.substring(0, core.length() - 1).trim();
        // Discard output into a fresh atom; no stream objects -> safe for JPL.
        return "with_output_to(atom(_), (" + core + "))";
    }

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

    private static String extractPredicate(String s) {
        if (s == null) return "";
        s = s.trim();
        Matcher m = Pattern.compile("^([a-zA-Z_][a-zA-Z0-9_]*)\\s*\\(").matcher(s);
        if (m.find()) return m.group(1);   // "legal(P,...)" -> "legal"
        if (s.endsWith(".")) s = s.substring(0, s.length() - 1).trim();
        return s;
    }

    /**
     * Turn off noisy style warnings globally at runtime (no edits to .pl files required).
     * Safe to call multiple times.
     */
    private static void silencePrologStyleWarnings() {
        try {
            new Query("style_check(-discontiguous)").hasSolution();
            new Query("style_check(-singleton)").hasSolution();
            new Query("( current_prolog_flag(verbose_load, _) -> set_prolog_flag(verbose_load, false) ; true )").hasSolution();
        } catch (Throwable ignored) {
            // If any of these aren’t supported, just continue.
        }
    }

    @Override
    public String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException {
        Issue.resetCounter();
        setProvenanceGraphPath(provenanceGraphPath);
        setTimeFilePath(timeDataPath);
        this.issues = new ArrayList<>();

        // Silence warnings before loading anything
        silencePrologStyleWarnings();

        // Minimal environment: time + graph + causality
        loadResource("/RGPD/causal_dependencies.pl");
        loadTimeTerms();

        // ---- PROLOG time printing (values + sources) ----
        printPrologTimeBlock();

        loadPrologFile(this.provenanceGraphPath);
        new Query("abolish_all_tables").hasSolution();

        if (PROLOG_TRACING_ENABLED_FOR_DEBUG) {

            new Query("leash(-all)").hasSolution();
            new Query("trace").hasSolution();
        }

        // Seen keys for dedup
        Set<String> seen = new HashSet<>();

        for (String goalText : principles) {
            // Accept only our 4 predicates; if the caller passes a full goal, extract its name
            final String pred = extractPredicate(goalText);
            if (!VALID_PREDICATES.contains(pred)) {
                // Skip preamble/noise goals
                continue;
            }

            // Map to IssueType and choose the actual Prolog goal to run
            final Issue.IssueType issueType = Issue.IssueType.fromString(pred);
            final String prologQuery = goalText.contains("(")
                    ? goalText
                    : getPrologQueryForPrinciple(issueType); // fall back to canonical goal

            // Load rule file for this principle
            String ruleFile = switch (issueType) {
                case RIGHT_TO_ERASURE -> "erase_compliant.pl";
                case RIGHT_TO_ACCESS -> "right_access.pl";
                case STORAGE_LIMITATION -> "storage_limitation.pl";
                case LEGAL -> "legal.pl";
                default -> "";
            };
            if (!ruleFile.isEmpty()) {
                try {
                    loadResource("/RGPD/" + ruleFile);
                    if (issueType == Issue.IssueType.LEGAL &&
                            prologDefaultsLoggedForGraph.add(this.provenanceGraphPath)) {
                        try {
                            // Compute list of default purposes without printing inside Prolog
                            Map<String, Term> sol =
                                    new Query("( setof(PU, default_purpose(PU), L) -> true ; L = [] )").oneSolution();

                            Term l = sol.get("L");
                            List<String> prologDefaults = new ArrayList<>();
                            if (l != null && l.isList()) {
                                for (Term t : org.jpl7.Util.listToTermArray(l)) {
                                    // atoms -> names; numbers -> toString()
                                    prologDefaults.add(t.isAtom() ? t.name() : t.toString());
                                }
                            }
                            System.out.println("Default purposes from Prolog: " + prologDefaults);
                        } catch (Throwable e) {
                            System.out.println("Default purposes from Prolog: [] (error: " + e.getMessage() + ")");
                        }
                    }

                } catch (IOException e) {
                    System.err.println("Warning: Could not load rule file: " + ruleFile);
                    continue;
                }
            }

            // Run, capture solutions, and DEDUP by canonical key per principle
            try {
                // DO NOT wrap with with_output_to/2 for enumerating answers.
                @SuppressWarnings("unchecked")
                HashMap<String, Term>[] sols = (HashMap<String, Term>[]) new Query(prologQuery).allSolutions();
                for (HashMap<String, Term> sol : sols) {
                    String key = makeDedupKey(issueType, sol);
                    if (!seen.add(key)) continue;
                    this.issues.add(new Issue(issueType.typeName, sol));
                }
            } catch (PrologException e) {
                System.err.println("Prolog error during query '" + prologQuery + "': " + e.getMessage());
            }
        }

        resetSolver();

        if (issues.isEmpty()) return "System is compliant.";
        StringBuilder sb = new StringBuilder();
        issues.forEach(i -> sb.append(i.toString()));
        return sb.toString();
    }

    @Override
    public List<Issue> getIssues() {
        return issues;
    }

    // Build a stable key for dedup per principle
    private static String makeDedupKey(Issue.IssueType type, HashMap<String, Term> sol) {
        String prefix = type.typeName + "|";
        return switch (type) {
            case LEGAL -> prefix + k(sol, "P","D","PU","T");
            case RIGHT_TO_ERASURE -> prefix + k(sol, "D","T","P");
            case RIGHT_TO_ACCESS -> prefix + k(sol, "S","TE");
            case STORAGE_LIMITATION -> prefix + k(sol, "D","TU");
            default -> prefix + UUID.randomUUID(); // shouldn't happen
        };
    }

    private static String k(HashMap<String, Term> sol, String... names) {
        StringBuilder sb = new StringBuilder();
        for (String n : names) {
            Term t = sol.get(n);
            sb.append(n).append('=').append(t == null ? "∅" : t.toString()).append('|');
        }
        return sb.toString();
    }

    private String getPrologQueryForPrinciple(Issue.IssueType type) {
        return switch (type) {
            case LEGAL -> "legal(P, D, PU, T, DP, C).";
            case RIGHT_TO_ERASURE -> "eraseCompliant(D, T, P).";
            case RIGHT_TO_ACCESS -> "rightAccess(S, TE).";
            case STORAGE_LIMITATION -> "storageLimitation(D, TU).";
            default -> "true.";
        };
    }

    /* === Prolog loading utilities === */

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

    void unloadAllFiles() {
        for (String path : filesLoad){
            Query pred = new Query("unload_file", new Term[] {new Atom(path)});
            pred.hasSolution();
        }
        filesLoad.clear();
    }

    void resetSolver(){
        unloadAllFiles();
    }

    void loadTimeTerms() throws IOException {
        loadPrologFile(timeDataPath);
    }

    /* === NEW: Print the time actually used by PROLOG === */

    private void printPrologTimeBlock() {
        try {
            String tf = timeDataPath;
            // make it safe to inject in a Prolog format/2 call
            String tfEsc = tf.replace("\\", "/").replace("'", "\\'");

            // Values (single line)
            new Query(
                    "tCurrent(T), findall([K,V], tLimit(K,V), Limits), " +
                            "format('[PROLOG-TIME] file=~w tCurrent=~w limits=~w~n', ['" + tfEsc + "', T, Limits])"
            ).hasSolution();

            // Sources (which files defined the clauses)
            new Query(
                    "findall(F, (clause(tCurrent(_),_,Ref), clause_property(Ref,file(F))), TFs), " +
                            "format('[PROLOG-TIME-SRC] tCurrent clauses from: ~w~n', [TFs])"
            ).hasSolution();

            new Query(
                    "findall(F, (clause(tLimit(_,_),_,Ref), clause_property(Ref,file(F))), LFs), " +
                            "format('[PROLOG-TIME-SRC] tLimit clauses from: ~w~n', [LFs])"
            ).hasSolution();

            new Query(
                    "findall(F, (clause(notAvailable(_,_),_,Ref), clause_property(Ref,file(F))), NFs), " +
                            "format('[PROLOG-TIME-SRC] notAvailable clauses from: ~w~n', [NFs])"
            ).hasSolution();

        } catch (Throwable e) {
            System.out.println("[PROLOG-TIME] file=" + timeDataPath);
            System.out.println("[PROLOG-TIME] (error reading time predicates: " + e.getMessage() + ")");
        }
    }
}

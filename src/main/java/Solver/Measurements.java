// File: src/main/java/Solver/Measurements.java
package Solver;

import GraphDB.Neo4jInterface;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.neo4j.driver.SessionConfig;

import java.io.*;
import java.util.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;

/**
 * Benchmarks Prolog vs Cypher; prints default purposes from the graph (Neo4j).
 * IMPORTANT: This class no longer consults Prolog files itself (to avoid polluting the global engine).
 * Prolog loading/unloading is entirely handled inside PrologSolver.
 */
public class Measurements {

    // Configuration constants
    private static final String RESULTS_FILE_NAME = "results.csv";
    private static final String TIME_FILE_PATH = "src/main/java/Solver/testfiles/benchmark/time_sn_noncompliant.pl";
    private static final String GRAPH_FOLDER = "src/main/java/Solver/testfiles/benchmark/"; // Your .pl graphs

    // Use just the principle names; PrologSolver will expand them to canonical goals.
    private static final List<String> PRINCIPLE_NAMES_TO_TEST = List.of(
          Issue.IssueType.LEGAL.typeName,               // "legal"

         Issue.IssueType.RIGHT_TO_ERASURE.typeName,    // "eraseCompliant"
            Issue.IssueType.RIGHT_TO_ACCESS.typeName ,   // "rightAccess"
           Issue.IssueType.STORAGE_LIMITATION.typeName   // "storageLimitation"
    );

    // Bench "one by one"
    private static final List<Issue.IssueType> PRINCIPLES = List.of(
          Issue.IssueType.LEGAL,
        Issue.IssueType.RIGHT_TO_ERASURE,
         Issue.IssueType.RIGHT_TO_ACCESS,
          Issue.IssueType.STORAGE_LIMITATION
    );

    private static final int NUMBER_OF_RUNS = 1;

    // Files to skip when iterating graphs folder
    private static final List<String> FILES_TO_SKIP_PARAM_PARSING = List.of(
            "causal_dependencies.pl",
            "time_sn_noncompliant.pl",
            "erase_compliant.pl",
            "right_access.pl",
            "storage_limitation.pl",
            "legal.pl",
            "time_default.pl",
            "time_all.pl"
    );

    private static String sanitize(String s) {
        return s.replaceAll("[^A-Za-z0-9._-]", "_");
    }

    /** Saves all issues for (file × solver × principle) into bench_issues/<file>/<solver>__<principle>.txt */
    private static void saveIssuesPerPrinciple(
            String sourceFileName,
            String solverName,
            String principleName,
            List<Issue> issues) {

        try {
            String baseFile = sanitize(sourceFileName);
            String solver   = sanitize(solverName);
            String princ    = sanitize(principleName);

            Path dir = Paths.get("bench_issues", baseFile);
            Files.createDirectories(dir);

            Path out = dir.resolve(solver + "__" + princ + ".txt");

            try (BufferedWriter w = Files.newBufferedWriter(out, StandardCharsets.UTF_8)) {
                w.write("# File      : " + sourceFileName + "\n");
                w.write("# Solver    : " + solverName + "\n");
                w.write("# Principle : " + principleName + "\n");
                w.write("# Issues    : " + issues.size() + "\n");
                w.write("\n");
                for (int i = 0; i < issues.size(); i++) {
                    // Issue.toString() already formats details. One per line is fine.
                    w.write(String.format("[%03d] %s%n", i + 1, issues.get(i).toString()));
                }
            }
        } catch (Exception e) {
            System.err.println("[WARN] Could not write issues file for "
                    + sourceFileName + " / " + solverName + " / " + principleName
                    + " : " + e.getMessage());
        }
    }


    public static void main(String[] args) throws IOException {

        File results = new File(RESULTS_FILE_NAME);

        // Per-principle CSV writers
        Map<String, BufferedWriter> perPrincipleWriters = new HashMap<>();
        try {
            for (Issue.IssueType p : PRINCIPLES) {
                String fn = "results_" + p.typeName + ".csv";
                BufferedWriter pbw = new BufferedWriter(new FileWriter(new File(fn)));
                pbw.write("FILE_NAME,TYPE,NB_USERS,SIZE_KO,NODE_COUNT,USER_COUNT,SOLVER,ISSUE_COUNT,SOLVING_TIME_MS\n");
                pbw.flush();
                perPrincipleWriters.put(p.typeName, pbw);
            }
        } catch (IOException e) {
            for (BufferedWriter w : perPrincipleWriters.values()) try { w.close(); } catch (Exception ignore) {}
            throw e;
        }

        // Global CSV
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(results))) {
            bw.write("FILE_NAME,TYPE,NB_USERS,SIZE_KO,NODE_COUNT,USER_COUNT,SOLVER,ISSUE_COUNT,SOLVING_TIME_MS\n");
            bw.flush();

            File graphDirectory = new File(GRAPH_FOLDER);
            if (!graphDirectory.exists() || !graphDirectory.isDirectory()) {
                System.err.println("❌ Erreur : Le dossier de graphes '" + GRAPH_FOLDER + "' n'existe pas ou n'est pas un répertoire.");
                return;
            }

            File[] filesList = graphDirectory.listFiles();
            if (filesList == null || filesList.length == 0) {
                System.out.println("No .pl files found in " + GRAPH_FOLDER);
                return;
            }

            Arrays.sort(filesList, Comparator.comparing(File::getName));

            // Shared Neo4j
            Neo4jInterface globalNeo4jInterface = new Neo4jInterface();
            globalNeo4jInterface.setParameters("bolt://localhost:7687", "neo4j", "01012002");

            try {
                for (File fileEntry : filesList) {
                    // Only .pl files
                    if (!fileEntry.isFile() || !fileEntry.getName().endsWith(".pl")) {
                        continue;
                    }

                    String name = fileEntry.getName();

                    // Skip copies
                    if (name.contains("-copy")) {
                        System.out.println("⏭️ Ignoré : Fichier de copie détecté : " + name + ". Veuillez supprimer les fichiers '-copy' pour éviter les avertissements Prolog de redéfinition.");
                        continue;
                    }

                    // Skip utility rule/time files
                    if (FILES_TO_SKIP_PARAM_PARSING.contains(name)) {
                        System.out.println("⏭️ Ignoré : Fichier utilitaire détecté (non un graphe de test) : " + name);
                        continue;
                    }

                    try {
                        String baseName = StringUtils.substringBefore(name, ".");
                        String[] params = baseName.split("_");
                        String type = "unknown";

                        // Infer type
                        if (baseName.equalsIgnoreCase("empty_prov_graph")) {
                            type = "provenance";
                        } else if (baseName.equalsIgnoreCase("generated_graph")) {
                            type = "generated";
                        } else if (baseName.equalsIgnoreCase("time_default")) {
                            type = "time_data";
                        } else if (baseName.toLowerCase().startsWith("webservergraph")) {
                            type = "webserver";
                        } else if (baseName.toLowerCase().startsWith("socialnetwork")) {
                            type = "socialnetwork";
                        } else if (baseName.toLowerCase().startsWith("testload")) {
                            type = "testload";
                        } else if (baseName.toLowerCase().startsWith("webstore")) {
                            type = "webstore";
                        } else if (baseName.toLowerCase().startsWith("twousers")) {
                            type = "users_test";
                        } else if (baseName.toLowerCase().contains("graph")) {
                            type = "graph";
                        } else if (baseName.toLowerCase().contains("time")) {
                            type = "time_data";
                        }
                        if (type.equals("unknown") && params.length >= 3) {
                            type = params[2];
                        }

                        long sizeKo = FileUtils.sizeOf(fileEntry) / 1000;

                        System.out.println("\n📂 Traitement du fichier : " + name + " | Type : " + type +  " | Taille : " + sizeKo + " Ko");

                        // Load graph into Neo4j for Cypher
                        System.out.println("  🌐 Chargement du graphe dans Neo4j pour le solveur Cypher...");
                        globalNeo4jInterface.retrieveGraphDB(fileEntry.getAbsolutePath());
                        System.out.println("  ✅ Graphe chargé dans Neo4j.");
                        long nodeCount = globalNeo4jInterface.countNodes();
                        long userCount = globalNeo4jInterface.countUsers();
                        String nbUsers = String.valueOf(userCount);
                        System.out.println("  📦 Nodes: " + nodeCount + " | 👥 Users: " + userCount);


                        // === Global bench: all principles by name ===
                        for (String solverType : List.of("Prolog", "Cypher")) {
                            System.out.print(" → Solveur " + solverType + " : ");
                            long totalTimeMs = 0;
                            boolean hasFailed = false;

                            List<String> currentPrinciples = PRINCIPLE_NAMES_TO_TEST;

                            // Warm-up
                            if (NUMBER_OF_RUNS > 1) {
                                System.out.print("(Warm-up...) ");
                                SolverInterface warmUpSolver = solverType.equals("Prolog")
                                        ? new PrologSolver()
                                        : new SolverCypher(globalNeo4jInterface);
                                try {
                                    warmUpSolver.solve(currentPrinciples, fileEntry.getPath(), TIME_FILE_PATH);
                                } catch (Exception e) {
                                    System.err.println("\n  ⚠️ Erreur pendant le warm-up avec " + solverType + " : " + e.getMessage());
                                } finally {
                                    if (warmUpSolver instanceof PrologSolver) {
                                        ((PrologSolver) warmUpSolver).resetSolver();
                                    }
                                }
                            }

                            int issuesCount = -1;
                            try {
                                SolverInterface countingSolver = solverType.equals("Prolog")
                                        ? new PrologSolver()
                                        : new SolverCypher(globalNeo4jInterface);

                                countingSolver.solve(currentPrinciples, fileEntry.getPath(), TIME_FILE_PATH);
                                issuesCount = (countingSolver.getIssues() == null) ? 0 : countingSolver.getIssues().size();

                                if (countingSolver instanceof PrologSolver) {
                                    ((PrologSolver) countingSolver).resetSolver();
                                }
                            } catch (Exception e) {
                                System.err.println("  ⚠️ Impossible de compter les issues (" + solverType + ") : " + e.getMessage());
                                issuesCount = -1; // failure mark
                            }

                            for (int i = 0; i < NUMBER_OF_RUNS; i++) {
                                SolverInterface solver = solverType.equals("Prolog")
                                        ? new PrologSolver()
                                        : new SolverCypher(globalNeo4jInterface);

                                long start = System.nanoTime();
                                try {
                                    solver.solve(currentPrinciples, fileEntry.getPath(), TIME_FILE_PATH);
                                } catch (Exception e) {
                                    System.err.println("\n  ⚠️ Erreur pendant exécution avec " + solverType + " (Run " + (i + 1) + ") : " + e.getMessage());
                                    hasFailed = true;
                                    totalTimeMs = -1;
                                    break;
                                } finally {
                                    if (solver instanceof PrologSolver) {
                                        ((PrologSolver) solver).resetSolver();
                                    }
                                }
                                long end = System.nanoTime();
                                totalTimeMs += (end - start) / 1_000_000;
                            }

                            long avgTime = hasFailed ? -1 : totalTimeMs / NUMBER_OF_RUNS;
                            if (!hasFailed) {
                                System.out.println("✅ Terminé | Temps moyen : " + avgTime + " ms");
                            } else {
                                System.out.println("❌ Échec");
                            }

                            bw.write(String.format(Locale.US,
                                    "%s,%s,%s,%d,%d,%d,%s,%d,%d\n",
                                    name, type, nbUsers, sizeKo, nodeCount, userCount, solverType, issuesCount, avgTime));
                            bw.flush();
                        }

                        // === Per-principle bench (one CSV per principle) ===
                        for (Issue.IssueType principle : PRINCIPLES) {
                            String principleName = principle.typeName;
                            BufferedWriter pbw = perPrincipleWriters.get(principleName);

                            for (String solverType : List.of("Prolog", "Cypher")) {
                                System.out.print(" → Solveur " + solverType + " [" + principleName + "] : ");
                                long totalTimeMs = 0;
                                boolean hasFailed = false;

                                List<String> single = List.of(principleName);

                                // Warm-up
                                if (NUMBER_OF_RUNS > 1) {
                                    System.out.print("(Warm-up...) ");
                                    SolverInterface warmUpSolver = solverType.equals("Prolog")
                                            ? new PrologSolver()
                                            : new SolverCypher(globalNeo4jInterface);
                                    try {
                                        warmUpSolver.solve(single, fileEntry.getPath(), TIME_FILE_PATH);
                                    } catch (Exception e) {
                                        System.err.println("\n  ⚠️ Erreur pendant le warm-up " + solverType + " [" + principleName + "] : " + e.getMessage());
                                    } finally {
                                        if (warmUpSolver instanceof PrologSolver) {
                                            ((PrologSolver) warmUpSolver).resetSolver();
                                        }
                                    }
                                }

                                int issuesCountOne = -1;
                                try {
                                    SolverInterface countingSolver = solverType.equals("Prolog")
                                            ? new PrologSolver()
                                            : new SolverCypher(globalNeo4jInterface);

                                    countingSolver.solve(single, fileEntry.getPath(), TIME_FILE_PATH);
                                    List<Issue> collected = (countingSolver.getIssues() == null)
                                            ? List.of()
                                            : countingSolver.getIssues();

                                    // ⬇️ save the per-(file×solver×principle) issues list
                                    saveIssuesPerPrinciple(name, solverType, principleName, collected);

                                    issuesCountOne = collected.size();

                                    if (countingSolver instanceof PrologSolver) {
                                        ((PrologSolver) countingSolver).resetSolver();
                                    }
                                } catch (Exception e) {
                                    System.err.println("  ⚠️ Impossible de compter les issues (" + solverType + " [" + principleName + "]) : " + e.getMessage());
                                    issuesCountOne = -1;
                                }


                                for (int i = 0; i < NUMBER_OF_RUNS; i++) {
                                    SolverInterface solver = solverType.equals("Prolog")
                                            ? new PrologSolver()
                                            : new SolverCypher(globalNeo4jInterface);

                                    long start = System.nanoTime();
                                    try {
                                        solver.solve(single, fileEntry.getPath(), TIME_FILE_PATH);
                                    } catch (Exception e) {
                                        System.err.println("\n  ⚠️ Erreur exécution " + solverType + " [" + principleName + "] (Run " + (i + 1) + ") : " + e.getMessage());
                                        hasFailed = true;
                                        totalTimeMs = -1;
                                        break;
                                    } finally {
                                        if (solver instanceof PrologSolver) {
                                            ((PrologSolver) solver).resetSolver();
                                        }
                                    }
                                    long end = System.nanoTime();
                                    totalTimeMs += (end - start) / 1_000_000;
                                }

                                long avgTime = hasFailed ? -1 : totalTimeMs / NUMBER_OF_RUNS;
                                if (!hasFailed) {
                                    System.out.println("✅ Terminé | Temps moyen : " + avgTime + " ms");
                                } else {
                                    System.out.println("❌ Échec");
                                }

                                pbw.write(String.format(Locale.US,
                                        "%s,%s,%s,%d,%d,%d,%s,%d,%d\n",
                                        name, type, nbUsers, sizeKo, nodeCount, userCount, solverType, issuesCountOne, avgTime));
                                pbw.flush();
                            }
                        }

                    } catch (Exception ex) {
                        System.err.println("🚫 Erreur générale avec le fichier " + fileEntry.getName() + " : " + ex.getMessage());
                        bw.write(String.format(Locale.US,
                                "%s,%s,%s,%d,%d,%d,%s,%d,%d\n",
                                fileEntry.getName(), "error", "error",
                                FileUtils.sizeOf(fileEntry) / 1000,
                                -1, -1, "N/A", -1, -1));
                        bw.flush();

                        for (BufferedWriter pbw : perPrincipleWriters.values()) {
                            pbw.write(String.format(Locale.US,
                                    "%s,%s,%s,%d,%d,%d,%s,%d,%d\n",
                                    fileEntry.getName(), "error", "error",
                                    FileUtils.sizeOf(fileEntry) / 1000,
                                    -1, -1, "N/A", -1, -1));
                            pbw.flush();
                        }
                    }
                }
            } finally {
                globalNeo4jInterface.close();
            }
        }

        // Close per-principle writers
        for (BufferedWriter w : perPrincipleWriters.values()) {
            try { w.close(); } catch (Exception ignore) {}
        }

        System.out.println("\n✅ Comparaison terminée ! Résultats dans " + RESULTS_FILE_NAME + " et results_<principe>.csv");
    }

    @SuppressWarnings("unused")
    private static String getSafe(String[] array, int index, String defaultValue) {
        return index < array.length ? array[index] : defaultValue;
    }
}

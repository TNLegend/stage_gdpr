package Solver;

import GraphDB.Neo4jInterface;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.util.*;

public class Measurements {

    // Configuration constants
    private static final String RESULTS_FILE_NAME = "results.csv";
    private static final String TIME_FILE_PATH = "src/main/java/Solver/testfiles/time_sn_noncompliant.pl";
    private static final String GRAPH_FOLDER = "src/main/java/Solver/testfiles/"; // Retained your path

    // Original Prolog queries - used for PrologSolver
    private static final List<String> PROLOG_QUERIES_TO_TEST = List.of(
            "legal(P, D, PU, T, DP, C).",
            "eraseCompliant(D, T, P).",
            "rightAccess(S, TE).",
            "storageLimitation(D, TU)."
    );

    // Principle names - used for CypherSolver (as seen in ScreenController's usage)
    // Assuming Issue.IssueType.typeName resolves to these strings.
    private static final List<String> CYPHER_PRINCIPLE_NAMES_TO_TEST = List.of(
            "LEGAL",
            "RIGHT_TO_ERASURE",
            "RIGHT_TO_ACCESS",
            "STORAGE_LIMITATION"
    );

    private static final int NUMBER_OF_RUNS = 10;
    // Set to true for detailed Prolog trace and debugging, false for performance measurements
    private static final boolean PROLOG_TRACING_ENABLED_FOR_DEBUG = false;

    // List of files to skip from standard parameter parsing, e.g., utility Prolog files
    private static final List<String> FILES_TO_SKIP_PARAM_PARSING = List.of(
            "causal_dependencies.pl",
            "time_sn_noncompliant.pl", // If this is ever placed in RGPD folder
            "erase_compliant.pl",
            "right_access.pl",
            "storage_limitation.pl",
            "legal.pl",
            "time_default.pl"
    );

    public static void main(String[] args) throws IOException {
        File results = new File(RESULTS_FILE_NAME);
        // Using try-with-resources for automatic closing of BufferedWriter
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(results))) {
            bw.write("FILE_NAME,TYPE,NB_USERS,SIZE_KO,SOLVER,SOLVING_TIME_MS\n");
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

            // Initialize Neo4jInterface once outside the file loop for efficiency
            // and configure it with your credentials.
            // **IMPORTANT**: Replace "bolt://localhost:7687", "neo4j", "rootroot" with your actual Neo4j connection details.
            Neo4jInterface globalNeo4jInterface = new Neo4jInterface();
            globalNeo4jInterface.setParameters("bolt://localhost:7687", "neo4j", "rootroot");

            for (File fileEntry : filesList) {
                // Skip directories and files not ending with .pl
                if (!fileEntry.isFile() || !fileEntry.getName().endsWith(".pl")) {
                    continue;
                }

                String name = fileEntry.getName();

                // Skip "copy" files that might be duplicates
                if (name.contains("-copy")) {
                    System.out.println("⏭️ Ignoré : Fichier de copie détecté : " + name + ". Veuillez supprimer les fichiers '-copy' pour éviter les avertissements Prolog de redéfinition.");
                    continue;
                }

                // Un-commented this 'continue' as discussed previously, it's essential
                // if these are not actual graph files for measurement.
                if (FILES_TO_SKIP_PARAM_PARSING.contains(name)) {
                    System.out.println("⏭️ Ignoré : Fichier utilitaire détecté (non un graphe de test) : " + name);
                    continue;
                }

                try {
                    String baseName = StringUtils.substringBefore(name, ".");
                    String[] params = baseName.split("_");

                    String nbUsers = "unknown"; // Default value for NB_USERS
                    String type = "unknown";    // Default value for TYPE

                    // --- Improved Parsing Logic for NB_USERS ---
                    if (params.length > 0) {
                        String firstSegment = params[0];
                        // Check if the first segment contains a number (e.g., "2users", "500", "webservergraph3")
                        if (firstSegment.matches(".*\\d+.*")) {
                            // Extract only digits. Handles "2users" -> "2", "WebServerGraph3" -> "3"
                            nbUsers = firstSegment.replaceAll("[^\\d]", "");
                        } else {
                            // Use the segment itself as a descriptive label (e.g., "SocialNetwork", "empty", "generated", "twoUsers")
                            nbUsers = firstSegment;
                        }
                    }

                    // --- Improved Parsing Logic for TYPE ---
                    // Prioritize specific whole file names or significant parts
                    if (baseName.equalsIgnoreCase("empty_prov_graph")) {
                        type = "provenance"; // More specific than just "graph"
                        nbUsers = "empty"; // Override nbUsers for this specific file, if 'empty' is a user type
                    } else if (baseName.equalsIgnoreCase("generated_graph")) {
                        type = "generated";
                        nbUsers = "generated"; // Override nbUsers
                    } else if (baseName.equalsIgnoreCase("time_default")) {
                        type = "time_data";
                        nbUsers = "default"; // Override nbUsers
                    } else if (baseName.toLowerCase().startsWith("webservergraph")) { // Catches WebServerGraph3.pl
                        type = "webserver";
                    } else if (baseName.toLowerCase().startsWith("socialnetwork")) { // Catches SocialNetwork_compliant.pl
                        type = "socialnetwork";
                    } else if (baseName.toLowerCase().startsWith("testload")) { // Catches testLoadPrologFile_subsetC.pl
                        type = "testload";
                    } else if (baseName.toLowerCase().startsWith("webstore")) { // Catches webstore_compliant.pl
                        type = "webstore";
                    } else if (baseName.toLowerCase().startsWith("twousers")) { // Catches twoUsers_compliant.pl
                        type = "users_test"; // Can be more specific if desired, e.g., "simple_users"
                    }
                    // Then, check for common suffixes
                    else if (params.length > 0 && params[params.length - 1].equalsIgnoreCase("compliant")) {
                        type = "compliant";
                    } else if (params.length > 0 && params[params.length - 1].equalsIgnoreCase("noncompliant")) {
                        type = "noncompliant";
                    }
                    // General fallbacks if no specific pattern matched above
                    else if (baseName.toLowerCase().contains("graph")) {
                        type = "graph"; // Generic graph if no other specific type
                    } else if (baseName.toLowerCase().contains("time")) {
                        type = "time_data"; // Generic time data if no specific type
                    }
                    // Final fallback to original logic for type (if it still helps for some naming conventions)
                    if (type.equals("unknown") && params.length >= 3) {
                        type = params[2];
                    }
                    // if still unknown, it remains "unknown"


                    long sizeKo = FileUtils.sizeOf(fileEntry) / 1000;

                    System.out.println("\n📂 Traitement du fichier : " + name + " | Type : " + type + " | Nb Users : " + nbUsers + " | Taille : " + sizeKo + " Ko");

                    // --- IMPORTANT: Load the graph into Neo4j once per file for Cypher solver ---
                    System.out.println("  🌐 Chargement du graphe dans Neo4j pour le solveur Cypher...");
                    globalNeo4jInterface.retrieveGraphDB(fileEntry.getAbsolutePath());
                    System.out.println("  ✅ Graphe chargé dans Neo4j.");


                    for (String solverType : List.of("Prolog", "Cypher")) {
                        System.out.print(" → Solveur " + solverType + " : ");
                        long totalTimeMs = 0; // Sum of times for all runs
                        boolean hasFailed = false;

                        // Determine which queries list to use based on solver type
                        List<String> currentQueriesToTest;
                        if (solverType.equals("Prolog")) {
                            currentQueriesToTest = PROLOG_QUERIES_TO_TEST;
                        } else { // Cypher
                            currentQueriesToTest = CYPHER_PRINCIPLE_NAMES_TO_TEST;
                        }

                        // Warm-up run for JVM and potentially solver specific caches (optional but good practice)
                        if (NUMBER_OF_RUNS > 1) {
                            System.out.print("(Warm-up...) ");
                            SolverInterface warmUpSolver;
                            if (solverType.equals("Prolog")) {
                                warmUpSolver = new PrologSolver(); // Retained your original constructor call
                            } else {
                                warmUpSolver = new SolverCypher(globalNeo4jInterface);
                            }
                            try {
                                warmUpSolver.solve(currentQueriesToTest, fileEntry.getPath(), TIME_FILE_PATH);
                            } catch (Exception e) {
                                System.err.println("\n  ⚠️ Erreur pendant le warm-up avec " + solverType + " : " + e.getMessage());
                            } finally {
                                if (warmUpSolver instanceof PrologSolver) {
                                    ((PrologSolver) warmUpSolver).resetSolver();
                                }
                            }
                        }

                        for (int i = 0; i < NUMBER_OF_RUNS; i++) {
                            SolverInterface solver;
                            if (solverType.equals("Prolog")) {
                                solver = new PrologSolver(); // Retained your original constructor call
                            } else {
                                solver = new SolverCypher(globalNeo4jInterface);
                            }

                            long start = System.nanoTime();
                            try {
                                solver.solve(currentQueriesToTest, fileEntry.getPath(), TIME_FILE_PATH);
                            } catch (Exception e) {
                                System.err.println("\n  ⚠️ Erreur pendant exécution avec " + solverType + " (Run " + (i + 1) + ") : " + e.getMessage());
                                hasFailed = true;
                                totalTimeMs = -1; // Indicate failure
                                break; // Stop further runs for this solver/file if it fails
                            } finally {
                                if (solver instanceof PrologSolver) {
                                    ((PrologSolver) solver).resetSolver();
                                }
                            }
                            long end = System.nanoTime();
                            totalTimeMs += (end - start) / 1_000_000; // Accumulate time in milliseconds
                        }

                        long avgTime = -1;
                        if (!hasFailed) {
                            avgTime = totalTimeMs / NUMBER_OF_RUNS;
                            System.out.println("✅ Terminé | Temps moyen : " + avgTime + " ms");
                        } else {
                            System.out.println("❌ Échec");
                        }

                        bw.write(String.format(Locale.US, "%s,%s,%s,%d,%s,%d\n",
                                name, type, nbUsers, sizeKo, solverType, avgTime));
                        bw.flush();
                    }

                } catch (Exception ex) {
                    System.err.println("🚫 Erreur générale avec le fichier " + fileEntry.getName() + " : " + ex.getMessage());
                    bw.write(String.format(Locale.US, "%s,%s,%s,%d,%s,%d\n",
                            fileEntry.getName(), "error", "error", FileUtils.sizeOf(fileEntry) / 1000, "N/A", -1));
                    bw.flush();
                }
            }
            globalNeo4jInterface.close(); // Retained your original close method call
        }
        System.out.println("\n✅ Comparaison terminée ! Résultats dans " + RESULTS_FILE_NAME);
    }

    private static String getSafe(String[] array, int index, String defaultValue) {
        return index < array.length ? array[index] : defaultValue;
    }
}
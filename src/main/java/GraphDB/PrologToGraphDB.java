package GraphDB;

import org.apache.commons.lang3.StringUtils;
import org.neo4j.driver.Driver;
import org.neo4j.driver.QueryConfig;
import org.neo4j.driver.Record;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Arrays;
import java.util.Objects;
import java.util.stream.Collectors;

public class PrologToGraphDB {

    /**
     * Looks through the GraphDB for an Artifact with this name. Returns the needed Artifact node, and creates it if not found.
     */
    private static Record getArtifact(Driver driver, String name) {
        // CORRECTION: Ajouter des quotes autour du nom dans la requête
        var result = driver.executableQuery("MATCH (p:Artifact {name: '" + name + "'}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Artifact {name: '" + name + "'}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Looks through the GraphDB for a Process with this name. Returns the needed Process node, and creates it if not found.
     */
    private static Record getProcess(Driver driver, String name) {
        // CORRECTION: Ajouter des quotes autour du nom dans la requête
        var result = driver.executableQuery("MATCH (p:Process {name: '" + name + "'}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Process {name: '" + name + "'}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Looks through the GraphDB for an Agent with this name. Returns the needed Agent node, and creates it if not found.
     */
    private static Record getAgent(Driver driver, String name) {
        // CORRECTION: Ajouter des quotes autour du nom dans la requête
        var result = driver.executableQuery("MATCH (p:Agent {name: '" + name + "'}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Agent {name: '" + name + "'}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Extracts parameters from a Prolog file line by retrieving the content between parenthesis and splitting between ",".
     * Strips any single-quotes around each parameter so we don’t double-quote in Cypher.
     */
    private static String[] extractClassicParameters(String line) {
        String t = StringUtils.substringBeforeLast(line, ")");
        String params = StringUtils.substringAfter(t, "(");
        return Arrays.stream(params.split(","))
                .map(String::trim)
                // <-- strip outer single-quotes here:
                .map(s -> StringUtils.strip(s, "'"))
                .toArray(String[]::new);
    }


    /**
     * Extracts parameters from a Prolog 'purposes' predicate.
     * Strips any single-quotes around each token so they’re ready for Cypher.
     */
    private static String[][] extractPurposesParameters(String line) {
        // 1) pull out the list of purposes inside the [ … ]
        String t1 = StringUtils.substringBeforeLast(line, "]");
        String purposesStr = StringUtils.substringAfter(t1, "[");
        String[] purposes = Arrays.stream(purposesStr.split(","))
                .map(String::trim)
                // strip outer single-quotes
                .map(s -> StringUtils.strip(s, "'"))
                .toArray(String[]::new);

        // 2) pull out the parameters inside the ( … )
        String t2 = StringUtils.substringBeforeLast(line, ")");
        String paramsStr = StringUtils.substringAfter(t2, "(");
        String[] params = Arrays.stream(paramsStr.split(","))
                .map(String::trim)
                // strip outer single-quotes
                .map(s -> StringUtils.strip(s, "'"))
                .toArray(String[]::new);

        return new String[][]{purposes, params};
    }


    /**
     * Converts a provenance graph from a Prolog file to a GraphDB. The currently stored GraphDB is deleted and replaced
     * by the newly generated provenance graph.
     */
    protected static void convert(Driver driver, String path) {

        try {
            File in = new File(path);
            FileReader fr = new FileReader(in);
            BufferedReader br = new BufferedReader(fr);

            String line;
            driver.executableQuery(
                            "MATCH (n) DETACH DELETE (n)")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute(); // emptying the GraphDB

            while ((line = br.readLine()) != null) {
                if (line.startsWith("%")) {
                    continue;
                }
                if (line.startsWith("wasControlledBy")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getAgent(driver, params[1]);

                    // CORRECTION: Formatter correctement toutes les propriétés avec quotes si nécessaire
                    driver.executableQuery(
                                    "MATCH (p:Process {name: '" + params[0] + "'}), (a:Agent {name: '" + params[1] + "'}) " +
                                            "CREATE (p)-[r:wasControlledBy {ctx: '" + params[2] + "', TB: " + params[3] + ", TE: " + params[4] + "}]->(a)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasGeneratedBy")) {
                    String[] params = extractClassicParameters(line);

                    getArtifact(driver, params[0]);
                    getProcess(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (a:Artifact {name: '" + params[0] + "'}), (p:Process {name: '" + params[1] + "'}) " +
                                            "CREATE (a)-[r:wasGeneratedBy {ctx: '" + params[2] + "', TG: " + params[3] + "}]->(p)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();

                    // === CORRECTION LOGIQUE ===
                    // On vérifie si le contexte (3ème paramètre) est 'personal data'
                    if (params.length > 2 && params[2].equals("personal data")) {
                        driver.executableQuery(
                                        "MATCH (a:Artifact {name: '" + params[0] + "'}) " +
                                                "SET a.type = 'personal_data', a.category = '" + params[2] + "'") // On peut réutiliser params[2] pour la catégorie
                                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                .execute();
                    }
                } else if (line.startsWith("used")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getArtifact(driver, params[1]);

                    // CORRECTION: Assurer que tous les timestamps sont correctement formatés
                    driver.executableQuery(
                                    "MATCH (p:Process {name: '" + params[0] + "'}), (a:Artifact {name: '" + params[1] + "'}) " +
                                            "CREATE (p)-[r:used {ctx: '" + params[2] + "', TU: " + params[3] + "}]->(a)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasTriggeredBy")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getProcess(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (p1:Process {name: '" + params[0] + "'}), (p2:Process {name: '" + params[1] + "'}) " +
                                            "CREATE (p1)-[r:wasTriggeredBy {ctx: '" + params[2] + "', T: " + params[3] + "}]->(p2)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasDerivedFrom")) {
                    String[] params = extractClassicParameters(line);

                    // CORRECTION: Les deux doivent être des Artifacts, pas des Process
                    getArtifact(driver, params[0]);
                    getArtifact(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (a1:Artifact {name: '" + params[0] + "'}), (a2:Artifact {name: '" + params[1] + "'}) " +
                                            "CREATE (a1)-[r:wasDerivedFrom {ctx: '" + params[2] + "', T: " + params[3] + "}]->(a2)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("action")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);

                    // CORRECTION: Ajouter quotes si nécessaire
                    driver.executableQuery(
                                    "MATCH (p:Process {name: '" + params[0] + "'}) " +
                                            "SET p.action = '" + params[1].replace("'", "") + "'")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("purposes")) {
                    String[][] res = extractPurposesParameters(line);
                    String[] purposes = res[0];
                    String[] params   = res[1];

                    String consentName = Objects.equals(params[0], "_")
                            ? "mandatory_consent"
                            : params[0];
                    getArtifact(driver, consentName);

                    String data = params[1];

                    // Build a Cypher list literal, NOT a quoted string
                    String purposesList = "[" +
                            Arrays.stream(purposes)
                                    .map(p -> "'" + p + "'")
                                    .collect(Collectors.joining(", "))
                            + "]";

                    driver.executableQuery(
                                    "MATCH (c:Artifact {name: '" + consentName + "'}) " +
                                            "SET c." + data + "_purposes = " + purposesList + ", " +
                                            "c.consent_type = 'purposes_consent'"
                            ).withConfig(QueryConfig.builder()
                                    .withDatabase("neo4j")
                                    .build())
                            .execute();
                }

            }

            br.close();
            fr.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
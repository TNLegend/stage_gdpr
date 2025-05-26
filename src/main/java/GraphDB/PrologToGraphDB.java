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

public class PrologToGraphDB {

    /**
     * Looks through the GraphDB for an Artifact with this name. Returns the needed Artifact node, and creates it if not found.
     *
     * @param driver GraphDB driver
     * @param name   Artifact name
     * @return Artifact to find (already existing or newly created)
     */
    private static Record getArtifact(Driver driver, String name) {
        var result = driver.executableQuery("MATCH (p:Artifact {name: " + name + "}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Artifact {name: " + name + "}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Looks through the GraphDB for a Process with this name. Returns the needed Process node, and creates it if not found.
     *
     * @param driver GraphDB driver
     * @param name   Process name
     * @return Process to find (already existing or newly created)
     */
    private static Record getProcess(Driver driver, String name) {
        var result = driver.executableQuery("MATCH (p:Process {name: " + name + "}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Process {name: " + name + "}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Looks through the GraphDB for an Agent with this name. Returns the needed Agent node, and creates it if not found.
     *
     * @param driver GraphDB driver
     * @param name   Agent name
     * @return Agent to find (already existing or newly created)
     */
    private static Record getAgent(Driver driver, String name) {
        var result = driver.executableQuery("MATCH (p:Agent {name: " + name + "}) RETURN p")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();

        if (result.records().isEmpty()) {
            result = driver.executableQuery("CREATE (p:Agent {name: " + name + "}) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();
        }

        return result.records().get(0);
    }

    /**
     * Extracts parameters from a Prolog file line by retrieving the content between parenthesis and splitting between ",". Does not work for lines with lists.
     *
     * @param line Prolog file line
     * @return String array containing the parameters list
     */
    private static String[] extractClassicParameters(String line) {
        String t = StringUtils.substringBeforeLast(line, ")");
        return StringUtils.substringAfter(t, "(").split(",");
    }

    /**
     * Extracts parameters from a Prolog 'purposes' predicate.
     *
     * @param line Prolog 'purposes' predicate line
     * @return String array of size 2 containing the purposes list and the other parameters list.
     */
    private static String[][] extractPurposesParameters(String line) {
        String t1 = StringUtils.substringBeforeLast(line, "]");
        String[] purposes = StringUtils.substringAfter(t1, "[").split(",");
        String t2 = StringUtils.substringBeforeLast(line, ")");
        String[] params = StringUtils.substringAfter(t2, "(").split(",");
        return new String[][]{purposes, params};
    }

    /**
     * Converts a provenance graph from a Prolog file to a GraphDB. The currently stored GraphDB is deleted and replaced
     * by the newly generated provenance graph.
     *
     * @param driver GraphDB driver
     * @param path   Prolog provenance graph path
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

                    driver.executableQuery(
                                    "MATCH (p:Process {name: " + params[0] + "}), (a:Agent {name: " + params[1] + "}) " +
                                            "CREATE (p)-[r:wasControlledBy {ctx:" + params[2] + ", TB:" + params[3] + ", TE:" + params[4] + "}]->(a)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasGeneratedBy")) {
                    String[] params = extractClassicParameters(line);

                    getArtifact(driver, params[0]);
                    getProcess(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (a:Artifact {name: " + params[0] + "}), (p:Process {name: " + params[1] + "}) " +
                                            "CREATE (a)-[r:wasGeneratedBy {ctx:" + params[2] + ", TG:" + params[3] + "}]->(p)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("used")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getArtifact(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (p:Process {name: " + params[0] + "}), (a:Artifact {name: " + params[1] + "}) " +
                                            "CREATE (p)-[r:used {ctx:" + params[2] + ", TU:" + params[3] + "}]->(a)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasTriggeredBy")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getProcess(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (p1:Process {name: " + params[0] + "}), (p2:Process {name: " + params[1] + "}) " +
                                            "CREATE (p1)-[r:wasTriggeredBy {ctx:" + params[2] + ", T:" + params[3] + "}]->(p2)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("wasDerivedFrom")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);
                    getProcess(driver, params[1]);

                    driver.executableQuery(
                                    "MATCH (a1:Artifact {name: " + params[0] + "}), (a2:Artifact {name: " + params[1] + "}) " +
                                            "CREATE (a1)-[r:wasDerivedFrom {ctx:" + params[2] + ", T:" + params[3] + "}]->(a2)")
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("action")) {
                    String[] params = extractClassicParameters(line);

                    getProcess(driver, params[0]);

                    driver.executableQuery(
                                    "MATCH (p:Process {name: " + params[0] + "}) " +
                                            "SET p.action = " + params[1])
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                } else if (line.startsWith("purposes")) {
                    String[][] res = extractPurposesParameters(line);

                    String[] purposes = res[0];
                    String[] params = res[1];

                    String consentName;
                    if (Objects.equals(params[0], "_")) {
                        consentName = "'mandatory_consent'";
                    } else {
                        consentName = params[0];
                    }
                    getArtifact(driver, consentName);

                    String data = params[1].replace("'", "");

                    driver.executableQuery(
                                    "MATCH (c:Artifact {name: " + consentName + "}) " +
                                            "SET c." + data + " = " + Arrays.toString(purposes))
                            .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                            .execute();
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }

}

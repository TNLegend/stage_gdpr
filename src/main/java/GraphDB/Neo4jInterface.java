package GraphDB;

import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.GraphDatabase;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.io.*;
import java.util.Objects;

import static com.sun.javafx.scene.control.skin.Utils.getResource;

public class Neo4jInterface {
    private String uri;
    private String user;
    private String password;
    public final String generatedPrologGraphPath = "src/main/resources/prov_graph.pl";

    /**
     * Necessary credentials required to log in to Neo4J
     * @param uri GraphDB URI
     * @param user GraphDB username
     * @param password GraphDB password
     */
    public void setParameters(String uri, String user, String password) {
        this.uri = uri;
        this.user = user;
        this.password = password;
    }

    /**
     * Retrieves the GraphDB provenance graph and writes a corresponding Prolog file (stored in Neo4jInterface.generatedPrologGraphPath)
     */
    public void retrievePrologPG(){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            GraphDBToProlog.convert(driver, generatedPrologGraphPath);
        }
    }

    /**
     * Retrieves the Prolog provenance graph and stores it to the GraphDB (replacing the previously stored DB)
     * @param path Prolog file to load to the GraphDB
     */
    public void retrieveGraphDB(String path){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            PrologToGraphDB.convert(driver, path);
        }
    }

    /**
     * Generates the HTML file allowing graph visualization. The index.html is generated based on the index_pattern.html file,
     * by filling in the credentials and CYPHER query. This query determines what we get to see from the DB. Depending on the
     * moment this method is called, it is either the whole graph or a subGraph centered on a specific issue.
     * TODO : change the way the credentials are managed (currently written directly to the HTML file)
     * @param query CYPHER query to retrieve selected elements from the DB
     */
    public void buildVizHtmlFile(String query) {
        try {
            // load the pattern and output as URIs so that any %20 etc is decoded
            URI patternUri = Objects
                    .requireNonNull(getClass().getResource("/index_pattern.html"))
                    .toURI();
            URI outputUri = Objects
                    .requireNonNull(getClass().getResource("/index.html"))
                    .toURI();

            Path patternPath = Path.of(patternUri);
            Path outputPath  = Path.of(outputUri);

            try (var br = Files.newBufferedReader(patternPath);
                 var bw = Files.newBufferedWriter(outputPath)) {
                String line;
                while ((line = br.readLine()) != null) {
                    for (String chunk : line.split("%")) {
                        switch (chunk) {
                            case "DB_URL"       -> bw.write(uri);
                            case "DB_USER"      -> bw.write(user);
                            case "DB_PW"        -> bw.write(password);
                            case "CYPHER_QUERY" -> bw.write(query);
                            default             -> bw.write(chunk);
                        }
                    }
                    bw.newLine();
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to build viz HTML", e);
        }


    }

}

package GraphDB;

import org.neo4j.driver.*;
import org.neo4j.driver.Record;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.Objects;

import static com.sun.javafx.scene.control.skin.Utils.getResource;

public class Neo4jInterface {
    private String uri;
    private String user;
    private String password;
    public final String generatedPrologGraphPath = "src/main/resources/prov_graph.pl";

    // ... setParameters, retrievePrologPG, et retrieveGraphDB restent inchangés ...

    public void setParameters(String uri, String user, String password) {
        this.uri = uri;
        this.user = user;
        this.password = password;
    }

    public void retrievePrologPG(){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            GraphDBToProlog.convert(driver, generatedPrologGraphPath);
        }
    }

    public void retrieveGraphDB(String path){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            PrologToGraphDB.convert(driver, path);
        }
    }

    // --- NOUVELLE MÉTHODE ---
    /**
     * Exécute une requête Cypher paramétrée et retourne le résultat brut.
     * @param query La requête Cypher à exécuter.
     * @param params Une map des paramètres pour la requête (ex: {"currentTime": 5000}).
     * @return Un objet Result contenant les lignes de la réponse.
     */
    public Result executeQuery(String query, Map<String, Object> params) {
        // On utilise un driver et une session pour cette seule requête.
        // Le try-with-resources s'assure que tout est bien fermé.
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
             var session = driver.session()) {

            System.out.println("Executing Cypher Query: " + query);
            return session.run(query, params);
        }
    }

    // ... buildVizHtmlFile reste inchangée ...
    public void buildVizHtmlFile(String query) {
        try {
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
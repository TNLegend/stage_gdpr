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
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.sun.javafx.scene.control.skin.Utils.getResource;

public class Neo4jInterface implements AutoCloseable {
    private String uri;
    private String user;
    private String password;
    private Driver  driver;
    public final String generatedPrologGraphPath = "src/main/resources/prov_graph.pl";

    public String getUri() { return uri; }
    public String getUser() { return user; }
    public String getPassword() { return password; }

    // ... setParameters, retrievePrologPG, et retrieveGraphDB restent inchangés ...

    public void setParameters(String uri, String user, String password) {
        this.uri = uri;
        this.user = user;
        this.password = password;
        if (driver != null) driver.close();               // reconfigure ?
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
        ensureIndexes();
    }

    private void ensureIndexes() {
        try ( var session = driver.session(SessionConfig.forDatabase("neo4j")) ) {
            session.writeTransaction(tx -> {
                // Notice: name BEFORE IF NOT EXISTS
                tx.run("CREATE INDEX idx_proc_action    IF NOT EXISTS FOR (p:Process)  ON (p.action)");
                tx.run("CREATE INDEX idx_art_type       IF NOT EXISTS FOR (a:Artifact) ON (a.type)");
                tx.run("CREATE INDEX idx_art_cons_type  IF NOT EXISTS FOR (a:Artifact) ON (a.consent_type)");
                tx.run("CREATE INDEX idx_wgb_TG         IF NOT EXISTS FOR ()-[r:wasGeneratedBy]-() ON (r.TG)");
                tx.run("CREATE INDEX idx_used_TU        IF NOT EXISTS FOR ()-[r:used]-()           ON (r.TU)");
                // optional: block until online
                tx.run("CALL db.awaitIndexes()");
                return null;
            });
        }
    }

    public void retrievePrologPG(){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            GraphDBToProlog.convert(driver, generatedPrologGraphPath);
        }
    }

    /* ⚙️ accès au driver pour Solver */
    public Driver getDriver() { return driver; }


    public void retrieveGraphDB(String path){
        try (var driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password))) {
            driver.verifyConnectivity();
            System.out.println("Neo4J connection established.");
            PrologToGraphDB.convert(driver, path);
        }
    }
    /* ⚙️ nouvelle méthode, lecture seule */
    public List<Record> runReadQuery(TransactionContext tx,
                                     String cypher,
                                     Map<String,Object> params) {
        return tx.run(cypher, params).list();
    }


    public List<Record> executeQuery(String cypher, Map<String,Object> params) {
        try (var session = driver.session(SessionConfig.forDatabase("neo4j"))) {
            return session.executeRead(tx -> runReadQuery(tx, cypher, params));
        }
    }
    @Override
    public void close() {
        if (driver != null) driver.close();
    }


    // ... buildVizHtmlFile reste inchangée ...
    public void buildVizHtmlFile(String query) {
        System.out.println("[DEBUG-NEO4J] Appel de buildVizHtmlFile avec la requête: " + query);
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
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
        ensureIndexesAndDebug();
    }

    public long countNodes() {
        var result = driver.executableQuery("MATCH (n) RETURN count(n) AS c")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();
        return result.records().isEmpty() ? 0L : result.records().get(0).get("c").asLong();
    }

    public long countUsers() {
        var result = driver.executableQuery("MATCH (:Agent) RETURN count(*) AS c")
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();
        return result.records().isEmpty() ? 0L : result.records().get(0).get("c").asLong();
    }


    private void ensureIndexesAndDebug() {
        System.out.println("--- Starting Index/Constraint creation ---");
        try (var session = driver.session(SessionConfig.forDatabase("neo4j"))) {

            long nodeCount = session.run("MATCH (n) RETURN count(n) AS count")
                    .single().get("count").asLong();
            if (nodeCount > 0) {
                System.out.println("[WARNING] Creating indexes on a non-empty DB (" + nodeCount + " nodes).");
            }

            // 0) Drop legacy/mistyped indexes
            var drops = List.of(
                    "DROP INDEX idx_art_name IF EXISTS",
                    "DROP INDEX idx_proc_name IF EXISTS",
                    "DROP INDEX idx_agent_name IF EXISTS",
                    "DROP INDEX idx_used_R IF EXISTS",
                    "DROP INDEX idx_wgb_R IF EXISTS",
                    "DROP INDEX idx_wcb_R IF EXISTS",
                    "DROP INDEX idx_used_R_TU IF EXISTS",
                    "DROP INDEX idx_wgb_R_TG IF EXISTS"
            );
            for (String q : drops) session.executeWrite(tx -> { tx.run(q); return null; });

// 1) Unique name constraints
            var constraints = List.of(
                    "CREATE CONSTRAINT cons_art_name   IF NOT EXISTS FOR (a:Artifact) REQUIRE a.name IS UNIQUE",
                    "CREATE CONSTRAINT cons_proc_name  IF NOT EXISTS FOR (p:Process)  REQUIRE p.name IS UNIQUE",
                    "CREATE CONSTRAINT cons_agent_name IF NOT EXISTS FOR (ag:Agent)   REQUIRE ag.name IS UNIQUE"
            );
            for (String q : constraints) session.executeWrite(tx -> { tx.run(q); return null; });

// 2) Indexes actually used by queries
            var indexes = List.of(
                    // Nodes
                    "CREATE INDEX idx_proc_action       IF NOT EXISTS FOR (p:Process)  ON (p.action)",
                    "CREATE INDEX idx_art_type          IF NOT EXISTS FOR (a:Artifact) ON (a.type)",
                    // removed idx_art_name2 (redundant with unique constraint)
                    "CREATE INDEX idx_art_personal_seq  IF NOT EXISTS FOR (a:Artifact) ON (a.personal_seq)",
                    "CREATE INDEX idx_art_consent_type  IF NOT EXISTS FOR (a:Artifact) ON (a.consent_type)",

                    // Relationships (ctx + time)
                    "CREATE INDEX idx_used_ctx          IF NOT EXISTS FOR ()-[r:used]-()            ON (r.ctx)",
                    "CREATE INDEX idx_used_TU           IF NOT EXISTS FOR ()-[r:used]-()            ON (r.TU)",
                    "CREATE INDEX idx_used_ctx_TU       IF NOT EXISTS FOR ()-[r:used]-()            ON (r.ctx, r.TU)",

                    "CREATE INDEX idx_wgb_ctx           IF NOT EXISTS FOR ()-[r:wasGeneratedBy]-()  ON (r.ctx)",
                    "CREATE INDEX idx_wgb_TG            IF NOT EXISTS FOR ()-[r:wasGeneratedBy]-()  ON (r.TG)",
                    "CREATE INDEX idx_wgb_ctx_TG        IF NOT EXISTS FOR ()-[r:wasGeneratedBy]-()  ON (r.ctx, r.TG)",

                    "CREATE INDEX idx_wcb_ctx           IF NOT EXISTS FOR ()-[r:wasControlledBy]-() ON (r.ctx)",
                    "CREATE INDEX idx_wcb_TE            IF NOT EXISTS FOR ()-[r:wasControlledBy]-() ON (r.TE)",
                    "CREATE INDEX idx_art_dp_key        IF NOT EXISTS FOR (a:Artifact) ON (a.dp_key)",
                    "CREATE INDEX idx_wdf_T IF NOT EXISTS FOR ()-[r:wasDerivedFrom]-() ON (r.T)"


                    // Optional:
                    //,"CREATE INDEX idx_wcb_ctx_TE        IF NOT EXISTS FOR ()-[r:wasControlledBy]-() ON (r.ctx, r.TE)"
            );
            for (String q : indexes) session.executeWrite(tx -> { tx.run(q); return null; });

            session.run("CALL db.awaitIndexes(60000)").consume();



            System.out.println("--- Index/Constraint creation done ---");
        } catch (Exception e) {
            System.err.println("[ERROR] During index/constraint creation: " + e.getMessage());
            throw new RuntimeException(e);
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
            System.out.println("Neo4J load complete: " + path);
        } catch (Exception e) {
            // unwrap root cause and print it
            Throwable root = e;
            while (root.getCause() != null) root = root.getCause();
            System.err.println("[LOAD-ERROR] " + e.getMessage());
            System.err.println("[LOAD-ERROR] Root cause: " + root.getClass().getSimpleName()
                    + " – " + String.valueOf(root.getMessage()));
            root.printStackTrace();
            throw new RuntimeException("Failed to load Prolog graph from " + path
                    + " (cause: " + root.getMessage() + ")", e);
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

package GraphDB;

import org.neo4j.driver.*;
import org.neo4j.driver.Record;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

public class GraphDBToProlog {

    private static String toPrologList(Object value) {
        if (value == null) return "[]";

        // Si Neo4j renvoie une vraie liste Java
        if (value instanceof Iterable<?> it) {
            StringBuilder sb = new StringBuilder("[");
            boolean first = true;
            for (Object o : it) {
                if (!first) sb.append(", ");
                sb.append("'").append(String.valueOf(o)).append("'");
                first = false;
            }
            sb.append("]");
            return sb.toString();
        }

        // Sinon on part du toString() – gère "[]", "[a, b]" etc.
        String raw = value.toString().trim();
        if (raw.equals("[]")) return "[]";
        // Normalise : [a, b] -> ['a','b']
        return raw.replace("[", "['")
                .replace("]", "']")
                .replace(",", "','")
                .replace(" ", "");
    }


    /**
     * Retrieves the GraphDB provenance graph and writes a corresponding Prolog file (stored in Neo4jInterface.generatedPrologGraphPath)
     * @param driver GraphDB driver
     * @param path Path to the generated Prolog provenance graph file
     */
    public static void convert(Driver driver, String path) {

        try {
            File out = new File(path);
            FileWriter fw = new FileWriter(out);
            BufferedWriter bw = new BufferedWriter(fw);

            // 'wasControlledBy' predicates
            var result = driver.executableQuery("MATCH (a:Agent)<-[w:wasControlledBy]-(p:Process) RETURN a,w,p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value a = r.get("a");
                Value p = r.get("p");
                Value w = r.get("w");
                bw.write(("wasControlledBy(" + p.get("name") + "," + a.get("name") + "," + w.get("ctx") + "," + w.get("TB") + "," + w.get("TE") + ").\n").replace("\"", "'"));
            }

            // 'wasGeneratedBy' predicates
            result = driver.executableQuery("MATCH (p:Process)<-[w:wasGeneratedBy]-(a:Artifact) RETURN p,w,a")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value a = r.get("a");
                Value p = r.get("p");
                Value w = r.get("w");
                bw.write(("wasGeneratedBy(" + a.get("name") + "," + p.get("name") + "," + w.get("ctx") + "," + w.get("TG") + ").\n").replace("\"", "'"));
            }

            // 'wasTriggeredBy' predicates
            result = driver.executableQuery("MATCH (p1:Process)<-[w:wasTriggeredBy]-(p2:Process) RETURN p1,w,p2")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value p1 = r.get("p1");
                Value p2 = r.get("p2");
                Value w = r.get("w");
                bw.write(("wasTriggeredBy(" + p2.get("name") + "," + p1.get("name") + "," + w.get("ctx") + "," + w.get("T") + ").\n").replace("\"", "'"));
            }

            // 'wasDerivedFrom' predicates
            result = driver.executableQuery("MATCH (d1:Artifact)<-[w:wasDerivedFrom]-(d2:Artifact) RETURN d1,w,d2")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value d1 = r.get("d1");
                Value d2 = r.get("d2");
                Value w = r.get("w");
                Value tVal = w.get("T");
                String tStr = (tVal == null || tVal.isNull()) ? "'0'" : tVal.toString(); // default 0 if absent
                bw.write(("wasDerivedFrom(" + d2.get("name") + "," + d1.get("name") + "," + w.get("ctx") + "," + tStr + ").\n").replace("\"", "'"));

            }

            // 'used' predicates
            result = driver.executableQuery("MATCH (a:Artifact)<-[u:used]-(p:Process) RETURN a,u,p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value a = r.get("a");
                Value p = r.get("p");
                Value u = r.get("u");
                bw.write(("used(" + p.get("name") + "," + a.get("name") + "," + u.get("ctx") + "," + u.get("TU") + ").\n").replace("\"", "'"));
            }

            // 'action' predicates
            result = driver.executableQuery("MATCH (p:Process) RETURN p")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                Value p = r.get("p");
                bw.write(("action(" + p.get("name") + "," + p.get("action") + ").\n").replace("\"", "'"));
            }

            // 'purposes' predicates — pour chaque artefact de consentement
            result = driver.executableQuery(
                            "MATCH (:Process)<-[:wasGeneratedBy {ctx:'consent'}]-(c:Artifact) RETURN c")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                HashMap<String, Object> consentArtifact = new HashMap<>(r.get("c").asMap());

                // Nom du consentement (1er arg de purposes/3)
                String consent = "'" + consentArtifact.get("name").toString() + "'";

                // On parcourt uniquement les propriétés *_purposes et on ignore les méta
                for (String key : consentArtifact.keySet()) {
                    if (key.equals("name") || key.equals("type") || key.equals("category") || key.equals("consent_type"))
                        continue;
                    if (!key.endsWith("_purposes")) continue;

                    // Retirer le suffixe "_purposes" pour obtenir le vrai nom de donnée
                    String data = key.substring(0, key.length() - "_purposes".length());

                    // 2e argument : nom de donnée ; "_" reste sans quotes
                    String dataArg = data.equals("_") ? "_" : "'" + data + "'";

                    // 3e argument : la liste Prolog normalisée
                    String list = toPrologList(consentArtifact.get(key));

                    bw.write(String.format("purposes(%s,%s,%s).\n", consent, dataArg, list));
                }
            }


            result = driver.executableQuery("MATCH (c:Artifact {name:'mandatory_consent'}) RETURN c")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            if (!result.records().isEmpty()) {
                HashMap<String, Object> mandatory = new HashMap<>(result.records().get(0).get("c").asMap());

                // consent = "_" (joker) — sans quotes
                String consentWildcard = "_";

                for (String key : mandatory.keySet()) {
                    if (key.equals("name") || key.equals("type") || key.equals("category") || key.equals("consent_type"))
                        continue;
                    if (!key.endsWith("_purposes")) continue;

                    String data = key.substring(0, key.length() - "_purposes".length());
                    String dataArg = data.equals("_") ? "_" : "'" + data + "'";
                    String list = toPrologList(mandatory.get(key));

                    bw.write(String.format("purposes(%s,%s,%s).\n", consentWildcard, dataArg, list));
                }
            }


            bw.close();
            fw.close();
            driver.close();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}

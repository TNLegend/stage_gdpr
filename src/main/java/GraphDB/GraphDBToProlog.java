package GraphDB;

import org.neo4j.driver.*;
import org.neo4j.driver.Record;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

public class GraphDBToProlog {

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
                bw.write(("wasDerivedFrom(" + d2.get("name") + "," + d1.get("name") + "," + w.get("ctx") + "," + w.get("T") + ").\n").replace("\"", "'"));
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

            // 'purposes' predicates
            result = driver.executableQuery("MATCH (:Process)<-[:wasGeneratedBy {ctx:'consent'}]-(c:Artifact) RETURN c")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            for (Record r : result.records()) {
                StringBuilder line;
                HashMap<String, Object> consentArtifact = new HashMap<>(r.get("c").asMap());
                String consent = consentArtifact.get("name").toString();
                consent = "'" + consent + "'";

                consentArtifact.remove("name");
                for (String data : consentArtifact.keySet()) {
                    line = new StringBuilder();
                    line.append("purposes(").append(consent).append(",");
                    if (data.equals("_")) {
                        line.append(data).append(",");
                    } else {
                        line.append("'").append(data).append("',");
                    }
                    if (consentArtifact.get(data).toString().equals("[]")){
                        line.append("[]");
                    } else {
                        line.append(consentArtifact.get(data).toString().replace("[", "['").replace("]", "']").replace(",", "','").replace(" ", ""));
                    }
                    line.append(").\n");
                    bw.write(line.toString());
                }
            }

            result = driver.executableQuery("MATCH (c:Artifact {name:'mandatory_consent'}) RETURN c")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            StringBuilder line;
            HashMap<String, Object> consentArtifact = new HashMap<>(result.records().get(0).get("c").asMap());
            String consent = "_";

            consentArtifact.remove("name");
            for (String data : consentArtifact.keySet()) {
                line = new StringBuilder();
                line.append("purposes(").append(consent).append(",");
                if (data.equals("_")) {
                    line.append(data).append(",");
                } else {
                    line.append("'").append(data).append("',");
                }
                if (consentArtifact.get(data).toString().equals("[]")){
                    line.append("[]");
                } else {
                    line.append(consentArtifact.get(data).toString().replace("[", "['").replace("]", "']").replace(",", "','").replace(" ", ""));
                }
                line.append(").\n");
                bw.write(line.toString());
            }

            bw.close();
            fw.close();
            driver.close();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}

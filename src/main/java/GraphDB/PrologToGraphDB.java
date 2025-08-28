package GraphDB;

import org.apache.commons.lang3.StringUtils;
import org.neo4j.driver.Driver;
import org.neo4j.driver.QueryConfig;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.*;

public class PrologToGraphDB {

    private static long personalSeq = 0;

    /* ---------- small helpers ---------- */

    private static Map<String,Object> db(String k, Object v) {
        return Collections.singletonMap(k, v);
    }
    private static Map<String,Object> db2(String k1, Object v1, String k2, Object v2) {
        Map<String,Object> m = new HashMap<>();
        m.put(k1, v1); m.put(k2, v2);
        return m;
    }
    private static Map<String,Object> db3(String k1,Object v1,String k2,Object v2,String k3,Object v3){
        Map<String,Object> m = new HashMap<>();
        m.put(k1,v1); m.put(k2,v2); m.put(k3,v3);
        return m;
    }

    private static long toLong(String s) { return Long.parseLong(s.trim()); }

    private static String sanitizePropKey(String raw) {
        String base = raw == null ? "" : raw.trim();
        if (base.isEmpty()) base = "unknown";
        String clean = base.replaceAll("[^A-Za-z0-9_]", "_");
        if (Character.isDigit(clean.charAt(0))) clean = "_" + clean;
        return clean;
    }

    private static String[] extractClassicParameters(String line) {
        String t = StringUtils.substringBeforeLast(line, ")");
        String params = StringUtils.substringAfter(t, "(");
        return Arrays.stream(params.split(","))
                .map(String::trim)
                .map(s -> StringUtils.strip(s, "'")) // remove outer quotes
                .toArray(String[]::new);
    }

    /** Remove a trailing Prolog '%' comment that is OUTSIDE single quotes. */
    private static String stripLineCommentOutsideQuotes(String s) {
        if (s == null || s.isEmpty()) return s;
        boolean inSq = false;
        StringBuilder out = new StringBuilder(s.length());
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '\'') {
                // Prolog escapes quote by doubling it: ''
                if (i + 1 < s.length() && s.charAt(i + 1) == '\'') {
                    out.append("''");
                    i++;
                    continue;
                }
                inSq = !inSq;
                out.append(c);
                continue;
            }
            if (c == '%' && !inSq) {
                // start of comment outside quotes -> cut rest
                break;
            }
            out.append(c);
        }
        return out.toString();
    }

    /** Remove any inline C-style block comments that begin & end on the SAME line. */
    private static String stripInlineBlockComments(String s) {
        if (s == null || s.isEmpty()) return s;
        String prev, cur = s;
        do {
            prev = cur;
            cur = cur.replaceAll("/\\*[^*]*\\*+(?:[^/*][^*]*\\*+)*/", "");
        } while (!cur.equals(prev));
        return cur;
    }

    /** Strip multi-line C-style block comments from a buffer we accumulated (used for purposes). */
    private static String stripMultilineBlockComments(String s) {
        if (s == null) return "";
        return s.replaceAll("(?s)/\\*.*?\\*/", "");
    }

    private static String[][] extractPurposesParameters(String line) {
        String t1 = StringUtils.substringBeforeLast(line, "]");
        String purposesStr = StringUtils.substringAfter(t1, "[");
        String[] purposes =
                StringUtils.isBlank(purposesStr)
                        ? new String[0]
                        : Arrays.stream(purposesStr.split(","))
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .map(s -> StringUtils.strip(s, "'"))
                        .filter(s -> !s.isEmpty())
                        .toArray(String[]::new);

        String t2 = StringUtils.substringBeforeLast(line, ")");
        String paramsStr = StringUtils.substringAfter(t2, "(");
        String[] params = Arrays.stream(paramsStr.split(","))
                .map(String::trim)
                .map(s -> StringUtils.strip(s, "'"))
                .toArray(String[]::new);

        return new String[][]{purposes, params};
    }

    private static void ensureArtifact(Driver driver, String name) {
        driver.executableQuery(
                        "MERGE (a:Artifact {name:$name}) " +
                                "ON CREATE SET a.purposes_key = $pkey " +
                                "RETURN a")
                .withParameters(Map.of("name", name, "pkey", sanitizePropKey(name) + "_purposes"))
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();
    }
    private static void ensureProcess(Driver driver, String name) {
        driver.executableQuery("MERGE (p:Process {name:$name}) RETURN p")
                .withParameters(db("name", name))
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();
    }
    private static void ensureAgent(Driver driver, String name) {
        driver.executableQuery("MERGE (a:Agent {name:$name}) RETURN a")
                .withParameters(db("name", name))
                .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                .execute();
    }

    /** Capture predicate name at head of fact line. */
    private static String headOf(String line) {
        var m = java.util.regex.Pattern
                .compile("^\\s*([A-Za-z_][A-Za-z0-9_]*)\\s*\\(")
                .matcher(line);
        return m.find() ? m.group(1) : "";
    }

    /* ---------- main converter ---------- */

    protected static void convert(Driver driver, String path) {
        BufferedReader br = null;
        try {
            personalSeq = 0;

            File in = new File(path);
            if (!in.exists()) throw new IllegalArgumentException("Graph file not found: " + path);

            br = new BufferedReader(new FileReader(in));

            // reset DB
            driver.executableQuery("MATCH (n) DETACH DELETE n")
                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                    .execute();

            String lineRaw;
            long lineNo = 0;

            boolean inBlockComment = false; // for multi-line /* ... */

            while ((lineRaw = br.readLine()) != null) {
                lineNo++;

                String raw = lineRaw;
                if (raw == null) continue;

                // if we are inside a multi-line block comment, look for the end
                if (inBlockComment) {
                    if (raw.contains("*/")) inBlockComment = false;
                    continue;
                }

                // remove inline same-line /* ... */ first
                raw = stripInlineBlockComments(raw);

                // if a multi-line block starts (and didn't end on this line), skip lines until it ends
                if (raw.contains("/*") && !raw.contains("*/")) {
                    inBlockComment = true;
                    continue;
                }

                // remove any trailing % comment outside quotes
                raw = stripLineCommentOutsideQuotes(raw);

                // trim and skip banners/empties
                raw = raw.trim();
                if (raw.isEmpty()) continue;
                if (raw.startsWith("%") || raw.startsWith("*")) continue;

                // normalize for parsing
                String line = raw.replaceFirst("^[^A-Za-z]*", "")
                        .replaceAll("\\s+", " ");
                if (line.isEmpty()) continue;

                try {
                    String name = headOf(line);
                    if (name.isEmpty()) continue;

                    switch (name) {
                        case "wasControlledBy": {
                            String[] p = extractClassicParameters(line);
                            String proc = p[0], agent = p[1], ctx = p[2];
                            long tb = toLong(p[3]), te = toLong(p[4]);

                            ensureProcess(driver, proc);
                            ensureAgent(driver, agent);

                            driver.executableQuery(
                                            "MATCH (p:Process {name:$proc}), (a:Agent {name:$agent}) " +
                                                    "MERGE (p)-[:wasControlledBy {ctx:$ctx, TB:$tb, TE:$te}]->(a)")
                                    .withParameters(Map.of("proc", proc, "agent", agent, "ctx", ctx, "tb", tb, "te", te))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();


                            break;
                        }

                        case "wasGeneratedBy": {
                            String[] p = extractClassicParameters(line);
                            String art = p[0], proc = p[1], ctx = p[2];
                            long tg = toLong(p[3]);

                            ensureArtifact(driver, art);
                            ensureProcess(driver, proc);

                            driver.executableQuery(
                                            "MATCH (a:Artifact {name:$art}), (p:Process {name:$proc}) " +
                                                    "MERGE (a)-[:wasGeneratedBy {ctx:$ctx, TG:$tg}]->(p)")
                                    .withParameters(Map.of("art", art, "proc", proc, "ctx", ctx, "tg", tg))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();

                            if ("personal data".equals(ctx)) {
                                long seq = ++personalSeq;
                                String dpKey = sanitizePropKey(art) + "_purposes";
                                driver.executableQuery(
                                                "MATCH (a:Artifact {name:$art}) " +
                                                        "SET a.type='personal_data', a.category=$cat, a.personal_seq=$seq, a.dp_key=$dpKey")
                                        .withParameters(Map.of("art", art, "cat", ctx, "seq", seq, "dpKey", dpKey))
                                        .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                        .execute();
                            }
                            break;
                        }

                        case "used": {
                            String[] p = extractClassicParameters(line);
                            String proc = p[0], art = p[1], ctx = p[2];
                            long tu = toLong(p[3]);

                            ensureProcess(driver, proc);
                            ensureArtifact(driver, art);

                            driver.executableQuery(
                                            "MATCH (p:Process {name:$proc}), (a:Artifact {name:$art}) " +
                                                    "MERGE (p)-[:used {ctx:$ctx, TU:$tu}]->(a)")
                                    .withParameters(Map.of("proc", proc, "art", art, "ctx", ctx, "tu", tu))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            break;
                        }

                        case "wasTriggeredBy": {
                            String[] p = extractClassicParameters(line);
                            String p1 = p[0], p2 = p[1], ctx = p[2];
                            long t = toLong(p[3]);

                            ensureProcess(driver, p1);
                            ensureProcess(driver, p2);

                            driver.executableQuery(
                                            "MATCH (p1:Process {name:$p1}), (p2:Process {name:$p2}) " +
                                                    "CREATE (p1)-[:wasTriggeredBy {ctx:$ctx, T:$t}]->(p2)")
                                    .withParameters(Map.of("p1", p1, "p2", p2, "ctx", ctx, "t", t))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            break;
                        }

                        case "wasDerivedFrom": {
                            String[] p = extractClassicParameters(line);
                            String d1 = p[0], d2 = p[1], ctx = p[2];
                            long t = toLong(p[3]);

                            ensureArtifact(driver, d1);
                            ensureArtifact(driver, d2);

                            driver.executableQuery(
                                            "MATCH (a1:Artifact {name:$d1}), (a2:Artifact {name:$d2}) " +
                                                    "CREATE (a1)-[:wasDerivedFrom {ctx:$ctx, T:$t}]->(a2)")
                                    .withParameters(Map.of("d1", d1, "d2", d2, "ctx", ctx, "t", t))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            break;
                        }

                        case "action": {
                            String[] p = extractClassicParameters(line);
                            String proc = p[0], action = p[1].replace("'", "");
                            ensureProcess(driver, proc);
                            driver.executableQuery(
                                            "MATCH (p:Process {name:$proc}) SET p.action = $act")
                                    .withParameters(db2("proc", proc, "act", action))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            break;
                        }

                        case "purposes": {
                            // accumulate until ")."
                            StringBuilder sb = new StringBuilder(line);
                            while (!sb.toString().matches("(?s).*\\)\\s*\\.")) {
                                String next = br.readLine();
                                if (next == null) break;
                                // strip inline comments on the fly as well
                                next = stripInlineBlockComments(next);
                                next = stripLineCommentOutsideQuotes(next);
                                sb.append(' ').append(next.trim());
                            }

                            // remove multi-line block comments from the accumulated fact
                            String fact = stripMultilineBlockComments(sb.toString()).trim();
                            // also trim any trailing inline % remnants once more (safety)
                            fact = stripLineCommentOutsideQuotes(fact).trim();

                            String[][] res = extractPurposesParameters(fact);
                            String[] purposes = res[0];
                            String[] p = res[1];

                            String consentName = Objects.equals(p[0], "_") ? "mandatory_consent" : p[0];
                            String data = p[1];
                            ensureArtifact(driver, consentName);

                            String prop = sanitizePropKey(data) + "_purposes";
                            List<String> list = Arrays.asList(purposes);

                            driver.executableQuery(
                                            "MATCH (c:Artifact {name:$name}) " +
                                                    "SET c." + prop + " = CASE " +
                                                    "  WHEN c." + prop + " IS NULL THEN $list " +
                                                    "  ELSE [x IN (c." + prop + " + $list) WHERE x IS NOT NULL] " +
                                                    "END, " +
                                                    "    c.consent_type = 'purposes_consent'")
                                    .withParameters(db2("name", consentName, "list", list))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            break;
                        }

                        case "notAvailable": {
                            String[] p = extractClassicParameters(line);
                            String artifact = p[0];
                            long tu = toLong(p[1]);

                            var r = driver.executableQuery(
                                            "MATCH (a:Artifact {name:$art})<-[u:used]-(:Process {action:'delete'}) " +
                                                    "WHERE u.TU = $tu RETURN count(*) AS c")
                                    .withParameters(db2("art", artifact, "tu", tu))
                                    .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                    .execute();
                            long c = r.records().isEmpty() ? 0L : r.records().get(0).get("c").asLong();

                            if (c == 0L) {
                                String procName = "__implicit_delete__" +
                                        artifact.replaceAll("[^A-Za-z0-9_]", "_") + "_" + tu;

                                driver.executableQuery(
                                                "MERGE (a:Artifact {name:$art}) " +
                                                        "MERGE (p:Process {name:$pname}) " +
                                                        "  ON CREATE SET p.action = 'delete', p.synthetic = true " +
                                                        "  ON MATCH  SET p.action = coalesce(p.action, 'delete') " +
                                                        "MERGE (p)-[u:used {TU:$tu}]->(a) " +
                                                        "  ON CREATE SET u.synthetic = true")
                                        .withParameters(db3("art", artifact, "pname", procName, "tu", tu))
                                        .withConfig(QueryConfig.builder().withDatabase("neo4j").build())
                                        .execute();
                            }
                            break;
                        }

                    }

                } catch (Exception perLine) {
                    throw new RuntimeException("Cypher load error at line " + lineNo + ": " + raw, perLine);
                }
            }

            /* ---------- derived lineage ---------- */
            driver.executableQuery("""
                MATCH (dOut:Artifact)-[wgb:wasGeneratedBy]->(p:Process)-[u:used]->(dIn:Artifact)
                WHERE dOut <> dIn
                MERGE (dOut)-[r:wasDerivedFrom {ctx:'derived'}]->(dIn)
                ON CREATE SET r.T = coalesce(wgb.TG, u.TU)
            """).withConfig(QueryConfig.builder().withDatabase("neo4j").build()).execute();

            driver.executableQuery("""
                MATCH (out:Artifact)-[:wasDerivedFrom]->(mid:Artifact)
                MATCH (mid)-[:wasDerivedFrom]->(in2:Artifact)
                WHERE out <> in2
                MERGE (out)-[:wasDerivedFrom {ctx:'derived2'}]->(in2)
            """).withConfig(QueryConfig.builder().withDatabase("neo4j").build()).execute();

            /* ---------- personal roots ---------- */
            driver.executableQuery("""
                MATCH (dp:Artifact {type:'personal_data'})
                MERGE (dp)-[:hasPersonalRoot]->(dp)
            """).withConfig(QueryConfig.builder().withDatabase("neo4j").build()).execute();

        } catch (Exception e) {
            throw new RuntimeException("Failed to load Prolog graph from " + path, e);
        } finally {
            try { if (br != null) br.close(); } catch (Exception ignore) {}
        }
    }
}

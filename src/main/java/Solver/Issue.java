package Solver;

import org.jpl7.Term;

import java.util.HashMap;
import java.util.Map;

public class Issue {
    private final String type;
    private final HashMap<String, Term> properties;
    private final int id;
    public static int GLOBAL_ID;


    public String getType() {
        return type;
    }

    public HashMap<String, Term> getProperties() {
        return properties;
    }

    public int getId() {
        return id;
    }

    public Issue(String type, HashMap<String, Term> properties) {
        this.type = type;
        this.properties = properties;
        this.id = GLOBAL_ID;
        GLOBAL_ID ++;
    }

    public String toCypherQuery() {
        final String P  = quoted(properties.get("P"));
        final String D  = quoted(properties.get("D"));
        final String S  = quoted(properties.get("S"));
        final String T  = properties.get("T")==null  ? "null" : properties.get("T").toString();
        final String TU = properties.get("TU")==null ? "null" : properties.get("TU").toString();
        final String TE = properties.get("TE")==null ? "null" : properties.get("TE").toString();

        String raw;
        switch(type) {
            // 1. CONSENT / LEGAL : usage sans consentement
            case "legal" ->
                    raw = String.format(
                            "MATCH (p:Process {name:%s})-[u:used {TU:%s}]-(d:Artifact {name:%s}) " +
                                    "RETURN p, u, d",
                            P, T, D);

            // 2. RIGHT-TO-ACCESS : accès sans réponse dans les temps
            case "rightAccess" ->
                    raw = String.format(
                            "MATCH (req:Process {action:'askDataAccess'})-[ctl:wasControlledBy {TE:%s}]-(a:Agent {name:%s}) " +
                                    "RETURN req, ctl, a",
                            TE, S);

            // 3. RIGHT-TO-ERASE : demande d’effacement non suivie d’action
            case "eraseCompliant" ->
                    raw = String.format(
                            "MATCH (e:Process {action:'askErase', name:%s})-[u:used {TU:%s}]-(d:Artifact {name:%s}) " +
                                    "RETURN e, u, d",
                            P, T, D);

            // 4. STORAGE-LIMITATION : données conservées au-delà du délai
            case "storageLimitation" ->
                    raw = String.format(
                            "MATCH (p:Process)-[u:used {TU:%s}]-(d:Artifact {name:%s}) " +
                                    "RETURN p, u, d",
                            TU, D);

            default ->
                    raw = "MATCH (n)-[r]-(m) RETURN n, r, m";
        }

        // compactage pour initial_cypher (JS)
        return raw.replaceAll("\\s+", " ").trim();
    }

    private static String quoted(Object o) {
        if (o == null) return "null";
        String s = o.toString().trim();
        return s.startsWith("'") ? s : "'" + s + "'";
    }


    @Override
    public String toString() {
        String fmt = TEMPLATES.getOrDefault(type,
                "[%d] ISSUE – details unavailable");
        return switch (type) {
            case "legal" -> String.format(fmt, id,
                    safe(properties.get("P")),
                    safe(properties.get("D")),
                    safe(properties.get("PU")),
                    safe(properties.get("T")));
            case "rightAccess" -> String.format(fmt, id,
                    safe(properties.get("S")),
                    safe(properties.get("TE")));
            case "eraseCompliant" -> String.format(fmt, id,
                    safe(properties.get("D")),
                    safe(properties.get("T")));
            case "storageLimitation" -> String.format(fmt, id,
                    safe(properties.get("D")),
                    safe(properties.get("TU")));
            default -> String.format(fmt, id);
        };
    }

    private static String safe(Object o){ return o==null ? "?" : o.toString(); }

    private static final Map<String,String> TEMPLATES = Map.of(
            "legal",
            "[%d] CONSENT ISSUE – process %s used %s for purpose %s at time %s without consent\n",
            "rightAccess",
            "[%d] ACCESS REQUEST ISSUE – subject %s asked for access at time %s and was not sent data in time\n",
            "eraseCompliant",
            "[%d] ERASE REQUEST ISSUE – erase of data %s was asked at %s but not done in time\n",
            "storageLimitation",
            "[%d] STORAGE LIMITATION ISSUE – data %s was last used at %s and not deleted in time\n"
    );

}

package Solver;

import GraphDB.Neo4jInterface;
import org.neo4j.driver.Result;
import org.neo4j.driver.SessionConfig;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class SolverCypher implements SolverInterface {

    private final Neo4jInterface neo;
    private List<Issue> issues = new ArrayList<>();

    // --- NOS 4 REQUÊTES CYPHER FINALES ET VALIDÉES ---

    /*  ERASE_QUERY_FAST  – O( nb(askErase) × petits sous-ensembles ) */
    private static final String ERASE_QUERY = """
MATCH (p_ask:Process {action:'askErase'})-[u_ask:used]->(d:Artifact)
WHERE $currentTime - u_ask.TU >= $erasureLimitDuration

AND NOT (
  EXISTS {
    MATCH (d)<-[u_del:used]-(:Process {action:'delete'})
    WHERE u_del.TU >= u_ask.TU
      AND u_del.TU  <  u_ask.TU + $erasureLimitDuration
  }
  OR (
    d.notAvailableSince IS NOT NULL
    AND d.notAvailableSince >= u_ask.TU
    AND d.notAvailableSince <  u_ask.TU + $erasureLimitDuration
  )
)

RETURN DISTINCT d.name AS D,
                u_ask.TU AS T,
                p_ask.name AS P
""";


    private static final String ACCESS_QUERY = """
// Parameters expected: $currentTime, $accessLimitDuration
MATCH (pAsk:Process {action:'askDataAccess'})
      -[wcbAsk:wasControlledBy {ctx:'owner'}]->(subj:Agent)
WITH pAsk,
     subj,
     wcbAsk.TB AS tAskStart,
     wcbAsk.TE AS tReq
WHERE $currentTime - tReq >= $accessLimitDuration     // window closed

/* ── request artefacts ───────────────────────────── */
MATCH (req:Artifact)-[wgb:wasGeneratedBy]->(pAsk)
WHERE wgb.TG >= tAskStart AND wgb.TG <= tReq
WITH subj, tReq, collect(DISTINCT req) AS reqs
WHERE size(reqs) > 0                                   // just in case

/* ── search for the *earliest* on-time reply (if any) */
CALL {
  WITH subj, reqs
  OPTIONAL MATCH (pSend:Process {action:'sendData'})
                -[:wasControlledBy {ctx:'owner'}]->(subj)
  OPTIONAL MATCH (pSend)-[:used]->(reqUsed:Artifact)
  WHERE reqUsed IS NULL OR reqUsed IN reqs
  OPTIONAL MATCH (resp:Artifact)-[wgbSend:wasGeneratedBy {ctx:'sendData'}]->(pSend)
  RETURN min(wgbSend.TG) AS firstReplyTE
}

/* ── flag violation ──────────────────────────────── */
WITH subj, tReq, firstReplyTE
WHERE firstReplyTE IS NULL
   OR firstReplyTE - tReq >= $accessLimitDuration
RETURN subj.name AS S, tReq AS TE
ORDER BY S, TE;

""";

    private static final String CONSENT_QUERY = """
            WITH $defaultPurposes AS defaults
            
            // 1) candidate uses (exclude synthetic)
            MATCH (p:Process)-[u:used]->(d:Artifact)
            WHERE p.action IS NOT NULL
              AND coalesce(p.synthetic,false) = false
              AND coalesce(u.synthetic,false) = false
            
            // 2) single personal root (materialized beforehand)
            MATCH (d)-[:hasPersonalRoot]->(dp:Artifact {type:'personal_data'})
            
            // 2.5) apply default allow-list: GLOBAL + DATA-SPECIFIC
            OPTIONAL MATCH (mc:Artifact {name:'mandatory_consent'})
            WITH p,u,d,dp,defaults, mc, coalesce(dp.dp_key, dp.purposes_key) AS prop
            WITH p,u,d,dp,defaults, mc, prop,
                 CASE WHEN mc IS NULL THEN [] ELSE coalesce(mc[prop], []) END AS dpDefaults
            WITH p,u,d,dp,defaults, mc, dpDefaults,
                 (p.action IN defaults) AS isGloballyAllowed
            WHERE NOT isGloballyAllowed
             // only global defaults are unconditional
            
            
            // 3) violation if NO valid consent for (dp, p.action) before u.TU,
            //    respecting revocations and later consents
            WITH p,u,d,dp, coalesce(dp.dp_key, dp.purposes_key) AS prop
            WHERE NOT EXISTS {
              // a consent artifact c granting p.action for dp
              MATCH (c:Artifact)-[wg:wasGeneratedBy {ctx:'consent'}]->(pGen:Process)
              MATCH (pGen)-[:wasControlledBy {ctx:'owner'}]->(:Agent)
              WHERE wg.TG < u.TU                                       // consent must predate the use
                AND (
                              p.action IN coalesce(c[prop], [])
                              OR p.action IN dpDefaults
                            )
            
                // validity condition (same as your Prolog logic)
                AND (
                  // (B) there exists a "next consent" after the use -> then the pre-use consent c is valid window
                  EXISTS {
                    MATCH (p2:Process)-[:used {ctx:'consent'}]->(c)
                    MATCH (:Artifact)-[wg1:wasGeneratedBy {ctx:'consent'}]->(p2)
                    MATCH (p2)-[:wasControlledBy {ctx:'owner'}]->(:Agent)
                    WHERE wg1.TG > u.TU
                  }
                  OR
                  // (A) c is the last consent and was not revoked on/before the use time
                  (
                    NOT EXISTS {
                      MATCH (p3:Process)-[:used {ctx:'consent'}]->(c)
                      MATCH (:Artifact)-[:wasGeneratedBy {ctx:'consent'}]->(p3)
                    }
                    AND (
                      NOT EXISTS { MATCH (:Process)-[rv:used {ctx:'revokeConsent'}]->(c) WHERE rv.TU <= u.TU }
                      OR  EXISTS  { MATCH (:Process)-[rv:used {ctx:'revokeConsent'}]->(c) WHERE rv.TU >  u.TU }
                    )
                  )
                )
            }
            
            RETURN DISTINCT p.name AS P, d.name AS D, p.action AS PU, u.TU AS T
            ORDER BY T;
""";




    // STORAGE — report every violating (d, TU). No var-length, no collect.
    private static final String STORAGE_QUERY = """
WITH ($currentTime - $storageLimitDuration) AS cutoff

MATCH (p:Process)-[u:used]->(d:Artifact)
WHERE p.action <> 'delete'
  AND u.TU <= cutoff

MATCH (d)-[:hasPersonalRoot]->(dp:Artifact {type:'personal_data'})
WITH d, u, dp
WHERE NOT (
  EXISTS {
    MATCH (:Process {action:'delete'})-[ud:used]->(dp)
    WHERE (ud.TU - u.TU) < $storageLimitDuration
  }
  OR (
    dp.notAvailableSince IS NOT NULL
    AND (dp.notAvailableSince - u.TU) < $storageLimitDuration
  )
)

RETURN DISTINCT d.name AS D, u.TU AS TU
ORDER BY TU
""";



    public SolverCypher(Neo4jInterface neo) {
        this.neo = neo;
    }
    private static final Set<String> printedGraphs =
            Collections.synchronizedSet(new HashSet<>());


    @Override
    public String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException {
        Issue.resetCounter(); //remttre le compteur d'issues a 0
        this.issues.clear();

        // 1. Charger les faits Prolog dans la base de données Neo4j
        //neo.retrieveGraphDB(provenanceGraphPath);

        // 2. Lire les paramètres de temps
        Map<String, Object> timeParams = parseTimeFile(timeDataPath);

        // 3. Exécuter les requêtes
        try (var session = neo.getDriver().session(SessionConfig.forDatabase("neo4j"))) {

            List<String> defaultPurposes = session.executeRead(tx -> {
                var rec = tx.run("""
        OPTIONAL MATCH (c:Artifact {name:'mandatory_consent'})
        RETURN CASE WHEN c IS NULL THEN [] ELSE coalesce(c.__purposes, []) END AS list
    """).single();
                return rec.get("list").asList(v -> v.asString());
            });


            if (printedGraphs.add(provenanceGraphPath)) {
                System.out.println("Default purposes from graph: " + defaultPurposes);
            }
            timeParams.put("defaultPurposes", defaultPurposes);




            for (String principleName : principles) {

                Issue.IssueType issueType = Issue.IssueType.fromString(principleName);
                String query = getCypherQueryForPrinciple(issueType);
                if (query == null) continue;

                /* ⬇️  UTILISER le même session, pas neo.executeQuery() */
                List<org.neo4j.driver.Record> records =
                        session.executeRead(tx -> neo.runReadQuery(tx, query, timeParams));

                for (org.neo4j.driver.Record rec : records) {
                    issues.add(new Issue(issueType, rec));
                }
            }
        }

        // 4. Formatter le résultat final
        if (issues.isEmpty()) {
            return "System is compliant.";
        } else {
            StringBuilder sb = new StringBuilder();
            issues.forEach(issue -> sb.append(issue.toString()));
            return sb.toString();
        }
    }

    @Override
    public List<Issue> getIssues() {
        return Collections.unmodifiableList(this.issues);
    }

    private String getCypherQueryForPrinciple(Issue.IssueType type) {
        return switch (type) {
            case RIGHT_TO_ERASURE -> ERASE_QUERY;
            case RIGHT_TO_ACCESS -> ACCESS_QUERY;
            case LEGAL -> CONSENT_QUERY;
            case STORAGE_LIMITATION -> STORAGE_QUERY;
            default -> null;
        };
    }

    private Map<String, Object> parseTimeFile(String path) throws IOException {
        System.out.println("[CYPHER-TIME] file=" + path);   // ← which file

        Map<String, Object> params = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("tCurrent")) {
                    params.put("currentTime", Integer.parseInt(extractValue(line)));
                } else if (line.startsWith("tLimit('access'")) {
                    params.put("accessLimitDuration", Integer.parseInt(extractValue(line)));
                } else if (line.startsWith("tLimit('erase'")) {
                    params.put("erasureLimitDuration", Integer.parseInt(extractValue(line)));
                } else if (line.startsWith("tLimit('storage'")) {
                    params.put("storageLimitDuration", Integer.parseInt(extractValue(line)));
                }
            }
        }
        System.out.println(
                "[CYPHER-TIME] tCurrent=" + params.get("currentTime")
                        + " storage=" + params.get("storageLimitDuration")
                        + " access="  + params.getOrDefault("accessLimitDuration","(none)")
                        + " erase="   + params.getOrDefault("erasureLimitDuration","(none)")
        );  // ← what values
        return params;
    }



    private String extractValue(String line) {
        // This regex pattern looks for digits inside the last pair of parentheses
        // It's designed to work for both "tCurrent(5000)" and "tLimit('access',1000)"
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\((\\d+)\\)|,\\s*(\\d+)\\)");
        java.util.regex.Matcher matcher = pattern.matcher(line);

        String value = null;
        while (matcher.find()) {
            if (matcher.group(1) != null) { // For "tCurrent(5000)" format
                value = matcher.group(1);
            } else if (matcher.group(2) != null) { // For "tLimit('access',1000)" format
                value = matcher.group(2);
            }
        }

        if (value != null) {
            return value;
        } else {
            // Handle cases where the value cannot be extracted (e.g., malformed lines)
            throw new IllegalArgumentException("Could not extract numerical value from line: " + line);
        }
    }
}
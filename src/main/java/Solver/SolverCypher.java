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
WHERE $currentTime - u_ask.TU >= $erasureLimitDuration          // fenêtre écoulée

AND NOT EXISTS {
      MATCH (d)<-[u_del:used]-(:Process {action:'delete'})
      WHERE u_del.TU >= u_ask.TU                                // après la demande
        AND u_del.TU  < u_ask.TU + $erasureLimitDuration        // avant la deadline
}
RETURN DISTINCT d.name AS D,
                u_ask.TU AS T,
                p_ask.name AS P
""";
    private static final String ACCESS_QUERY = """
// ---------------- ACCESS_QUERY (optimisée & équivalente) ----------------
MATCH (pAsk:Process {action:'askDataAccess'})
      -[wcbAsk:wasControlledBy {ctx:'owner'}]->(subject:Agent)
WITH pAsk, subject, wcbAsk.TE AS tReq
WHERE $currentTime - tReq >= $accessLimitDuration           // délai écoulé

// artefact-requête généré exactement à tReq
MATCH (req:Artifact)-[wgb:wasGeneratedBy]->(pAsk)
WHERE wgb.TG = tReq                                         // jointure ferme
  AND NOT EXISTS {                                          // aucun envoi valable
        MATCH (pSend:Process {action:'sendData'})
              -[uSend:used]->(req)                          // même artefact
        WHERE uSend.TU  >  tReq
          AND uSend.TU  -  tReq < $accessLimitDuration      // dans la fenêtre
      }

RETURN DISTINCT subject.name AS S ,
                tReq              AS TE

""";

    private static final String CONSENT_QUERY = """
/* ─────────────────────────────────────────────────────────────────────────────
   AVANT la première exécution, créez les index une seule fois :

   CREATE INDEX idx_proc_action       IF NOT EXISTS FOR (p:Process)  ON (p.action);
   CREATE INDEX idx_art_type          IF NOT EXISTS FOR (a:Artifact) ON (a.type);
   CREATE INDEX idx_art_cons_type     IF NOT EXISTS FOR (a:Artifact) ON (a.consent_type);
   CREATE INDEX idx_wgb_TG            IF NOT EXISTS FOR ()-[r:wasGeneratedBy]-() ON (r.TG);
   CREATE INDEX idx_used_TU           IF NOT EXISTS FOR ()-[r:used]-()           ON (r.TU);
            
   ───────────────────────────────────────────────────────────────────────────── */
/* =====================================================================
   CONSENT_QUERY  
   ===================================================================== */
MATCH (p_use:Process)-[u:used]->(d_used:Artifact)
WHERE NOT p_use.action IN $defaultPurposesList          // 1) action non triviale

/* ── 2) remonter jusqu’à UNE racine de donnée personnelle ───────────── */
CALL {
  WITH d_used
  MATCH (d_used)-[:wasGeneratedBy|used|wasDerivedFrom*0..]-
        (root:Artifact {type:'personal_data'})          // ← liaison non orientée
  RETURN root LIMIT 1                                           // 1ʳᵉ racine suffit
  
}

/* ── 3) consentement valable le plus récent avant l’usage ───────────── */
WITH p_use, u.TU AS TU_use, p_use.action AS PU,
     d_used, root
OPTIONAL MATCH (c:Artifact {consent_type:'purposes_consent'})
      -[wgb:wasGeneratedBy]->(:Process)
WHERE wgb.TG < TU_use
  AND PU IN c[root.name + '_purposes']

  // pas de révocation couvrant l’intervalle
  AND NOT EXISTS {
        MATCH (:Process)-[u_rev:used {ctx:'revokeConsent'}]->(c)
        WHERE u_rev.TU >= wgb.TG AND u_rev.TU < TU_use
      }

WITH p_use, TU_use, PU, d_used,
     c ORDER BY wgb.TG DESC
WITH p_use, TU_use, PU, d_used,
     collect(c)[0] AS c_latest            // le consentement le + récent

/* ── 4) signaler les usages sans consentement ───────────────────────── */
WHERE c_latest IS NULL
RETURN DISTINCT
       p_use.name  AS P,
       d_used.name AS D,
       PU          AS PU,
       TU_use      AS T
ORDER BY T;

""";

    private static final String STORAGE_QUERY = """
/* =====================================================================
   STORAGE_QUERY — équivalent à storageLimitation(D,TU) en Prolog
   ---------------------------------------------------------------------
   Hypothèses d’index déjà créés manuellement :
     CREATE INDEX idx_proc_action       IF NOT EXISTS FOR (p:Process)  ON (p.action);
     CREATE INDEX idx_art_type          IF NOT EXISTS FOR (a:Artifact) ON (a.type);
   ===================================================================== */
MATCH (art:Artifact)<-[u:used]-(p:Process)

/* ── une seule agrégation balaye TOUTES les utilisations de l’artefact ── */
WITH art,
     max( CASE WHEN p.action <> 'delete' THEN u.TU END ) AS last_use,   // dernier usage « normal »
     max( CASE WHEN p.action  = 'delete' THEN u.TU END ) AS last_del    // dernier delete éventuel

/* ── 1) délai de conservation dépassé ────────────────────────────────── */
WHERE last_use IS NOT NULL
  AND $currentTime - last_use >= $storageLimitDuration

/* ── 2) pas de suppression effectuée à temps ─────────────────────────── */
  AND ( last_del IS NULL                // jamais supprimé
        OR last_del - last_use >= $storageLimitDuration )

/* ── 3) l’artefact (ou un ancêtre) est une donnée personnelle ─────────── */
  AND EXISTS {
        MATCH (art)-[:wasGeneratedBy|used|wasDerivedFrom*0..]->
              (:Artifact)-[wgb:wasGeneratedBy]->(:Process)
        WHERE wgb.ctx = 'personal data'
        RETURN 1 LIMIT 1                        // stoppe l’expansion dès qu’un ancêtre perso est trouvé
  }

/* ── 4) signal de non-conformité ─────────────────────────────────────── */
RETURN DISTINCT art.name AS D, last_use AS TU
ORDER BY TU;

""";

    public SolverCypher(Neo4jInterface neo) {
        this.neo = neo;
    }

    @Override
    public String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException {
        this.issues.clear();

        // 1. Charger les faits Prolog dans la base de données Neo4j
        //neo.retrieveGraphDB(provenanceGraphPath);

        // 2. Lire les paramètres de temps
        Map<String, Object> timeParams = parseTimeFile(timeDataPath);
        timeParams.put("defaultPurposesList", List.of("consent", "delete", "askErase", "sendData", "askDataAccess", "updateConsent", "accessWebPage", "updateData", "createAccount", "login"));

        // 3. Exécuter les requêtes
        try (var session = neo.getDriver().session(SessionConfig.forDatabase("neo4j"))) {

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
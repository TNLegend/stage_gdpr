package Solver;

import GraphDB.Neo4jInterface;
import org.neo4j.driver.Result;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class SolverCypher implements SolverInterface {

    private final Neo4jInterface neo;
    private List<Issue> issues = new ArrayList<>();

    // --- NOS 4 REQUÊTES CYPHER FINALES ET VALIDÉES ---

    private static final String ERASE_QUERY = """
MATCH (p_ask:Process {action: 'askErase'})-[u_ask:used]->(d_target:Artifact)
WHERE $currentTime - u_ask.TU >= $erasureLimitDuration
  AND NOT EXISTS {
        MATCH (d_target)<-[u_delete:used]-(:Process {action: 'delete'})
        WHERE u_delete.TU >  u_ask.TU
          AND u_delete.TU - u_ask.TU < $erasureLimitDuration
  }
RETURN DISTINCT
       d_target.name AS D,
       u_ask.TU      AS T,
       p_ask.name    AS P
""";
    private static final String ACCESS_QUERY = """
// ---------- ACCESS_QUERY ----------
MATCH (s_demandeur:Agent)<-[wcb_ask:wasControlledBy {ctx:'owner'}]-
      (p_demande:Process {action:'askDataAccess'})

MATCH (a_demande:Artifact)-[wgb_ask:wasGeneratedBy]->(p_demande)
WHERE wcb_ask.TE = wgb_ask.TG          // TE_demande = horodatage de la demande

WITH s_demandeur, a_demande, wcb_ask.TE AS TE_demande
WHERE $currentTime - TE_demande >= $accessLimitDuration   // délai dépassé

  // Aucun « sendData » couvrant la demande dans le délai :
  AND NOT EXISTS {
        MATCH (p_envoi:Process {action:'sendData'})-[u_send:used]->(a_demande)
        MATCH (:Agent)<-[wcb_send:wasControlledBy {ctx:'owner'}]-(p_envoi)
        WHERE wcb_send.TE > TE_demande
          AND wcb_send.TE - TE_demande < $accessLimitDuration
  }

RETURN DISTINCT s_demandeur.name AS S,
                TE_demande        AS TE
""";

    private static final String CONSENT_QUERY = """
// ── Usage d’une donnée perso sans consentement valable ──
MATCH (p_use:Process)-[u:used]->(d_used:Artifact)
WITH p_use, d_used, p_use.action AS PU, u.TU AS TU_use
WHERE NOT (PU IN $defaultPurposesList)

/* 1. remonter jusqu’à la donnée personnelle source */
CALL {
    WITH d_used
    MATCH (d_used)-[:wasGeneratedBy|used|wasDerivedFrom*0..]-(dp_src:Artifact)
          -[wgb_src:wasGeneratedBy]->(:Process)
    WHERE wgb_src.ctx = 'personal data'
    RETURN DISTINCT dp_src
}

WITH p_use, d_used, dp_src, PU, TU_use

/* 2. vérifier qu’aucun consentement valable ne couvre cet usage */
WHERE NOT EXISTS {
    MATCH (c:Artifact {consent_type:'purposes_consent'})
          -[wgb_c:wasGeneratedBy]->(:Process)
    WHERE wgb_c.TG < TU_use
      AND c[dp_src.name + '_purposes'] IS NOT NULL
      AND PU IN c[dp_src.name + '_purposes']

      // pas de révocation avant l’usage
      AND NOT EXISTS {
            MATCH (:Process)-[u_rev:used {ctx:'revokeConsent'}]->(c)
            WHERE u_rev.TU >= wgb_c.TG AND u_rev.TU < TU_use
      }

      // pas de consentement plus récent et valide avant l’usage
      AND NOT EXISTS {
            MATCH (c2:Artifact {consent_type:'purposes_consent'})
                  -[wgb2:wasGeneratedBy]->(:Process)
            WHERE c2 <> c
              AND wgb2.TG >  wgb_c.TG
              AND wgb2.TG <  TU_use
              AND c2[dp_src.name + '_purposes'] IS NOT NULL
              AND PU IN c2[dp_src.name + '_purposes']
              AND NOT EXISTS {
                    MATCH (:Process)-[u_rev2:used {ctx:'revokeConsent'}]->(c2)
                    WHERE u_rev2.TU >= wgb2.TG AND u_rev2.TU < TU_use
              }
      }
}

RETURN DISTINCT p_use.name AS P,
                d_used.name AS D_used,
                PU,
                TU_use AS T
""";

    private static final String STORAGE_QUERY = """
// Dépassement de délai de conservation
MATCH (art:Artifact)<-[u:used]-(p:Process)
WHERE p.action <> 'delete'

WITH art, max(u.TU) AS last_TU                        // on garde `art`
WHERE $currentTime - last_TU >= $storageLimitDuration

// vérifier que l’artefact (ou l’une de ses dérivées) est perso
AND EXISTS {
    MATCH (art)-[:wasGeneratedBy|used|wasDerivedFrom*0..]-
          (:Artifact)-[r:wasGeneratedBy]->()
    WHERE r.ctx = 'personal data'
}

// vérifier qu’il n’a pas été supprimé à temps
AND NOT EXISTS {
    MATCH (art)<-[u_del:used]-(:Process {action:'delete'})
    WHERE u_del.TU > last_TU
      AND u_del.TU - last_TU < $storageLimitDuration
}

RETURN DISTINCT art.name AS D, last_TU AS TU
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
        for (String principleName : principles) {
            Issue.IssueType issueType = Issue.IssueType.fromString(principleName);
            String query = getCypherQueryForPrinciple(issueType);

            if (query != null) {
                // CHANGEMENT : On récupère maintenant une List<Record>
                List<org.neo4j.driver.Record> records = neo.executeQuery(query, timeParams);

                // On parcourt la liste avec une boucle for-each standard
                for (org.neo4j.driver.Record record : records) {
                    issues.add(new Issue(issueType, record));
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
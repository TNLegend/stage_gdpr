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
        OPTIONAL MATCH (p_delete:Process {action: 'delete'})-[u_delete:used]->(d_target) WHERE u_delete.TU > u_ask.TU
        WITH d_target, p_ask, u_ask.TU AS TU_askErase, min(u_delete.TU) AS minDeletionTimestamp
        WHERE $currentTime - TU_askErase >= $erasureLimitDuration AND (minDeletionTimestamp IS NULL OR minDeletionTimestamp - TU_askErase >= $erasureLimitDuration)
        RETURN DISTINCT d_target.name AS D, TU_askErase AS T, p_ask.name AS P
        """;

    private static final String ACCESS_QUERY = """
        MATCH (s_demandeur:Agent)<-[wcb_ask:wasControlledBy]-(p_demande:Process {action: 'askDataAccess'}) WHERE wcb_ask.ctx = 'owner'
        MATCH (a_demande:Artifact)-[wgb_ask:wasGeneratedBy]->(p_demande) WHERE wcb_ask.TE = wgb_ask.TG
        WITH s_demandeur, a_demande, wcb_ask.TE AS TE_demande
        WHERE $currentTime - TE_demande >= $accessLimitDuration
        AND NOT EXISTS {
          MATCH (p_envoi:Process {action: 'sendData'})-[u_send:used]->(a_demande)
          MATCH (agent_systeme:Agent)<-[wcb_send:wasControlledBy]-(p_envoi)
          WHERE wcb_send.TE > TE_demande AND (wcb_send.TE - TE_demande < $accessLimitDuration)
        }
        RETURN DISTINCT s_demandeur.name AS S, TE_demande AS TE
        """;

    private static final String CONSENT_QUERY = """
        MATCH (p_using_data:Process)-[u:used]->(d_artifact_used:Artifact) WITH p_using_data, d_artifact_used, u
        CALL {
            WITH d_artifact_used
            MATCH (d_artifact_used)-[r:wasGeneratedBy]->(:Process) WHERE r.ctx = 'personal data'
            RETURN d_artifact_used AS dp_source
            UNION
            WITH d_artifact_used
            MATCH (d_artifact_used)-[:wasGeneratedBy]->(:Process)-[:used]->(source)
            MATCH (source)-[r:wasGeneratedBy]->(:Process) WHERE r.ctx = 'personal data'
            RETURN source AS dp_source
        }
        WITH p_using_data, dp_source, d_artifact_used, u, p_using_data.action AS PU, u.TU AS T_utilisation
        WHERE NOT PU IN $defaultPurposesList
        AND NOT EXISTS {
            MATCH (c:Artifact {consent_type: 'purposes_consent'})-[wgb_c:wasGeneratedBy]->(:Process)
            WHERE wgb_c.TG < T_utilisation AND c[dp_source.name + '_purposes'] IS NOT NULL AND PU IN c[dp_source.name + '_purposes']
            AND NOT EXISTS { MATCH (p_revoke:Process {action:'revokeConsent'})-[u_revoke:used]->(c) WHERE u_revoke.TU < T_utilisation AND u_revoke.TU >= wgb_c.TG }
            AND NOT EXISTS {
                MATCH (c_next:Artifact {consent_type:'purposes_consent'})-[wgb_c_next:wasGeneratedBy]->(:Process)
                WHERE c_next <> c AND wgb_c_next.TG > wgb_c.TG AND wgb_c_next.TG < T_utilisation AND c_next[dp_source.name + '_purposes'] IS NOT NULL AND PU IN c_next[dp_source.name + '_purposes']
                AND NOT EXISTS { MATCH (p_revoke_next:Process {action:'revokeConsent'})-[u_revoke_next:used]->(c_next) WHERE u_revoke_next.TU < T_utilisation AND u_revoke_next.TU >= wgb_c_next.TG }
            }
        }
        RETURN DISTINCT p_using_data.name AS P, d_artifact_used.name AS D_used, PU, T_utilisation AS T
        """;

    private static final String STORAGE_QUERY = """
        MATCH (p_usage:Process)-[u_usage:used]->(artifact_used:Artifact) WHERE p_usage.action <> 'delete'
        WITH artifact_used, max(u_usage.TU) AS actual_last_usage_TU
        WHERE $currentTime - actual_last_usage_TU >= $storageLimitDuration
        CALL {
            WITH artifact_used
            MATCH (artifact_used)-[r:wasGeneratedBy]->(:Process) WHERE r.ctx = 'personal data' OR r.ctx = 'ad to send'
            RETURN artifact_used AS dp_source
            UNION
            WITH artifact_used
            MATCH (artifact_used)-[:wasGeneratedBy]->(:Process)-[:used]->(source)
            MATCH (source)-[r:wasGeneratedBy]->(:Process) WHERE r.ctx = 'personal data' OR r.ctx = 'ad to send'
            RETURN source AS dp_source
        }
        WITH dp_source, artifact_used, actual_last_usage_TU
        WHERE NOT EXISTS {
            MATCH (p_delete:Process {action: 'delete'})-[u_delete:used]->(dp_source)
            WHERE u_delete.TU > actual_last_usage_TU AND u_delete.TU - actual_last_usage_TU < $storageLimitDuration
        }
        RETURN DISTINCT artifact_used.name AS D, actual_last_usage_TU AS TU
        """;


    public SolverCypher(Neo4jInterface neo) {
        this.neo = neo;
    }

    @Override
    public String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException {
        this.issues.clear();

        // 1. Charger les faits Prolog dans la base de données Neo4j
        neo.retrieveGraphDB(provenanceGraphPath);

        // 2. Lire les paramètres de temps
        Map<String, Object> timeParams = parseTimeFile(timeDataPath);
        timeParams.put("defaultPurposesList", List.of("consent", "delete", "askErase", "sendData", "askDataAccess", "updateConsent", "accessWebPage", "updateData", "createAccount", "login"));

        // 3. Exécuter les requêtes
        for (String principleName : principles) {
            Issue.IssueType issueType = Issue.IssueType.fromString(principleName);
            String query = getCypherQueryForPrinciple(issueType);

            if (query != null) {
                Result result = neo.executeQuery(query, timeParams);
                result.forEachRemaining(record -> issues.add(new Issue(issueType, record)));
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
        try {
            return line.substring(line.lastIndexOf(',') + 1, line.lastIndexOf(')')).trim();
        } catch (Exception e) {
            // Gère le cas tCurrent(5000) qui n'a pas de virgule
            return line.substring(line.indexOf('(') + 1, line.indexOf(')')).trim();
        }
    }
}
package Solver;

import org.jpl7.Term;
import org.neo4j.driver.Record;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class Issue {

    /**
     * Un Enum pour définir les types de violation de manière propre et sûre.
     * Placé à l'intérieur de la classe pour garder tout dans un seul fichier.
     */
    public enum IssueType {
        LEGAL("legal"),
        RIGHT_TO_ACCESS("rightAccess"),
        RIGHT_TO_ERASURE("eraseCompliant"),
        STORAGE_LIMITATION("storageLimitation"),
        UNKNOWN("unknown");

        public final String typeName;

        IssueType(String typeName) { this.typeName = typeName; }

        public static IssueType fromString(String text) {
            for (IssueType b : IssueType.values()) {
                if (b.typeName.equalsIgnoreCase(text)) {
                    return b;
                }
            }
            return UNKNOWN;
        }
    }

    // --- CHAMPS DE LA CLASSE ---

    private final IssueType type;
    // CHANGEMENT MAJEUR : On utilise une Map<String, Object> générique au lieu de dépendre de Term.
    private final Map<String, Object> properties;
    private final int id;
    // CHANGEMENT : On utilise un compteur thread-safe pour les ID.
    private static final AtomicInteger counter = new AtomicInteger(0);

    // --- CONSTRUCTEURS ---

    /**
     * Constructeur pour les résultats venant du solveur Prolog.
     * Il prend les anciens termes Prolog et les convertit dans notre Map générique.
     * @param type Le type de violation (sous forme de String, pour la compatibilité).
     * @param prologProperties La map des résultats de JPL7.
     */
    public Issue(String type, HashMap<String, Term> prologProperties) {
        this.type = IssueType.fromString(type);
        this.properties = new HashMap<>();
        // On convertit les Term en String pour les stocker de manière uniforme.
        prologProperties.forEach((key, value) -> {
            this.properties.put(key, value.toString().replace("'", ""));
        });
        this.id = counter.incrementAndGet();
    }

    /**
     * Constructeur pour les résultats venant du solveur Cypher.
     * @param type Le type de violation (notre Enum).
     * @param cypherRecord L'enregistrement retourné par le driver Neo4j.
     */
    public Issue(IssueType type, Record cypherRecord) {
        this.type = type;
        // La méthode asMap() du driver Neo4j fait tout le travail pour nous !
        this.properties = cypherRecord.asMap();
        this.id = counter.incrementAndGet();
    }

    // --- GETTERS ---

    public int getId() { return id; }
    public IssueType getIssueType() { return type; }
    public String getType() { return type.typeName; } // Pour la compatibilité avec l'ancien code
    public Map<String, Object> getProperties() { return properties; }


    // --- MÉTHODES D'AFFICHAGE ET DE VISUALISATION ---

    /**
     * Génère le message lisible pour l'interface utilisateur.
     * La logique est la même, mais adaptée pour utiliser l'Enum et les bonnes clés.
     */
    @Override
    public String toString() {
        String template = TEMPLATES.getOrDefault(this.type, "[%d] ISSUE – details unavailable\n");

        return switch (type) {
            // Note : Pour 'legal', la clé est maintenant 'D_used' pour correspondre à notre requête Cypher.
            case LEGAL -> String.format(template, id, safe(properties.get("P")), safe(properties.get("D")), safe(properties.get("PU")), safe(properties.get("T")));
            case RIGHT_TO_ACCESS -> String.format(template, id, safe(properties.get("S")), safe(properties.get("TE")));
            case RIGHT_TO_ERASURE -> String.format(template, id, safe(properties.get("D")), safe(properties.get("T")));
            case STORAGE_LIMITATION -> String.format(template, id, safe(properties.get("D")), safe(properties.get("TU"))); // TU pour Storage
            default -> String.format(template, id);
        };
    }

    // Dans la classe Solver.Issue, remplacez la méthode toCypherQuery existante par celle-ci :

    /**
     * Génère une requête Cypher pour visualiser le contexte d'une issue,
     * en incluant maintenant l'agent qui contrôle le processus.
     */
    public String toCypherQuery() {
        // Les variables sont extraites des propriétés de l'issue
        final String P = quoted(properties.get("P"));
        final String D = quoted(properties.getOrDefault("D", properties.get("D_used")));
        final String S = quoted(properties.get("S"));
        final String T = properties.get("T") != null
                ? properties.get("T").toString()
                : properties.getOrDefault("TU", properties.get("TE")).toString();

        String rawQuery;
        switch (type) {
            case LEGAL:
            case RIGHT_TO_ERASURE:
                // CHANGEMENT : Le chemin inclut maintenant (Agent)-[:wasControlledBy]->(Process)
                rawQuery = String.format(
                        "MATCH path = (agent:Agent)<-[:wasControlledBy]-(p:Process {name:%s})-[r:used]->(d:Artifact {name:%s}) WHERE r.TU = %s RETURN path",
                        P, D, T
                );
                break;

            case RIGHT_TO_ACCESS:
                // PAS DE CHANGEMENT : L'agent était déjà le point de départ de la requête.
                rawQuery = String.format(
                        "MATCH path = (a:Agent {name:%s})<-[r:wasControlledBy]-(p:Process {action:'askDataAccess'}) WHERE r.TE = %s RETURN path",
                        S, T
                );
                break;

            case STORAGE_LIMITATION:
                // CHANGEMENT : Le chemin identifie maintenant le processus et l'agent qui l'a contrôlé.
                rawQuery = String.format(
                        "MATCH path = (agent:Agent)<-[:wasControlledBy]-(p:Process)-[r:used]->(d:Artifact {name:%s}) WHERE r.TU = %s RETURN path",
                        D, T
                );
                break;

            default:
                rawQuery = "MATCH (n)-[r]-(m) RETURN n,r,m";
                break;
        }

        // Nettoyage de la requête pour éviter les erreurs de syntaxe dues aux espaces.
        return rawQuery.replaceAll("\\s+", " ").trim();
    }

    // --- MÉTHODES UTILITAIRES ---

    private static String safe(Object o) {
        return o == null ? "?" : o.toString();
    }

    private static String quoted(Object o) {
        if (o == null) return "null";
        String s = o.toString().trim();
        // S'assure que les valeurs numériques ne sont pas entourées d'apostrophes pour Cypher
        if (s.matches("-?\\d+(\\.\\d+)?")) {
            return s;
        }
        return s.startsWith("'") ? s : "'" + s + "'";
    }

    // On utilise notre Enum comme clé pour la Map, c'est plus sûr.
    private static final Map<IssueType, String> TEMPLATES = Map.of(
            IssueType.LEGAL, "[%d] CONSENT ISSUE – process %s used %s for purpose %s at time %s without consent\n",
            IssueType.RIGHT_TO_ACCESS, "[%d] ACCESS REQUEST ISSUE – subject %s asked for access at time %s and was not sent data in time\n",
            IssueType.RIGHT_TO_ERASURE, "[%d] ERASE REQUEST ISSUE – erase of data %s was asked at %s but not done in time\n",
            IssueType.STORAGE_LIMITATION, "[%d] STORAGE LIMITATION ISSUE – data %s was last used at %s and not deleted in time\n"
    );
}
package Solver;

import java.io.IOException;
import java.util.List;

/**
 * Définit le contrat que toutes les classes "Solver" (Prolog, Cypher, etc.)
 * doivent respecter pour être utilisables par le reste de l'application.
 */
public interface SolverInterface {

    /**
     * Méthode principale qui exécute la logique de détection des violations.
     * @param principles La liste des noms des principes à vérifier (ex: "rightAccess").
     * @param provenanceGraphPath Le chemin vers le fichier de données Prolog.
     * @param timeDataPath Le chemin vers le fichier de configuration temporelle.
     * @return Une chaîne de caractères formatée avec tous les résultats pour l'affichage.
     * @throws IOException Si un fichier ne peut être lu.
     */
    String solve(List<String> principles, String provenanceGraphPath, String timeDataPath) throws IOException;

    /**
     * Retourne la liste des objets Issue trouvés après l'exécution de solve().
     * Utile pour des affichages plus complexes comme une ListView.
     * @return Une liste d'objets Issue.
     */
    List<Issue> getIssues();
}
package Traducteur;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Classe de tests unitaires pour la classe Converter.
 * Utilise JUnit 5.
 */
class testConverter {

    // On déclare les variables ici
    private Converter converter;
    private List<String> selectedPrinciples;
    private List<String> selectedDatas;
    private List<String> selectedUsers;
    private List<String> selectedProcesses;

    /**
     * Cette méthode est exécutée AVANT CHAQUE test.
     * Elle garantit que chaque test démarre avec des listes propres et vides,
     * évitant ainsi que les tests ne s'influencent les uns les autres.
     */
    @BeforeEach
    void setUp() {
        selectedPrinciples = new ArrayList<>();
        selectedDatas = new ArrayList<>();
        selectedUsers = new ArrayList<>();
        selectedProcesses = new ArrayList<>();
    }

    @Test
    @DisplayName("Devrait retourner une liste vide si aucun principe n'est sélectionné")
    void testEmptyPrincipleList() {
        // Arrange
        converter = new Converter(selectedPrinciples, "path", null, null, null);

        // Act
        List<String> queries = converter.ConvertToPrologQuery();

        // Assert
        assertTrue(queries.isEmpty(), "La liste de requêtes devrait être vide si aucun principe n'est sélectionné.");
    }

    @Test
    @DisplayName("Devrait générer des requêtes par défaut quand les listes de filtres sont nulles")
    void testDefaultQueriesWhenFiltersAreNull() {
        // Arrange
        selectedPrinciples.add("Lawfullness");
        selectedPrinciples.add("Right-to-access");
        converter = new Converter(selectedPrinciples, "path", null, null, null);

        // Act
        List<String> queries = converter.ConvertToPrologQuery();

        // Assert
        assertAll("Vérification des requêtes par défaut",
                () -> assertEquals(2, queries.size()),
                () -> assertEquals("legal(P, D, PU, T, DP, C).", queries.get(0)),
                () -> assertEquals("rightAccess(S, TE).", queries.get(1))
        );
    }

    @Test
    @DisplayName("Devrait générer des requêtes spécifiques avec des filtres fournis")
    void testSpecificQueriesWithFilters() {
        // Arrange
        selectedPrinciples.add("Right-to-erasure");
        selectedDatas.add("'data_1'"); // Les termes Prolog sont souvent des atomes (entre apostrophes)

        converter = new Converter(selectedPrinciples, "path", selectedDatas, null, null);

        // Act
        List<String> queries = converter.ConvertToPrologQuery();

        // Assert
        assertEquals(1, queries.size());
        assertEquals("eraseCompliant('data_1', T, P).", queries.get(0));
    }

    @Test
    @DisplayName("Devrait générer un produit cartésien de requêtes pour 'Lawfullness'")
    void testCartesianProductForLawfullness() {
        // Arrange
        selectedPrinciples.add("Lawfullness");
        selectedDatas.add("'data_1'");
        selectedDatas.add("'data_2'");
        selectedProcesses.add("'process_A'");
        selectedProcesses.add("'process_B'");

        converter = new Converter(selectedPrinciples, "path", selectedDatas, null, selectedProcesses);

        // Act
        List<String> queries = converter.ConvertToPrologQuery();

        // Assert
        assertEquals(4, queries.size());
        assertTrue(queries.contains("legal('process_A', 'data_1', PU, T, DP, C)."));
        assertTrue(queries.contains("legal('process_A', 'data_2', PU, T, DP, C)."));
        assertTrue(queries.contains("legal('process_B', 'data_1', PU, T, DP, C)."));
        assertTrue(queries.contains("legal('process_B', 'data_2', PU, T, DP, C)."));
    }

    @Test
    @DisplayName("Devrait ignorer les noms de principes inconnus")
    void testUnknownPrinciple() {
        // Arrange
        selectedPrinciples.add("Right-to-access");
        selectedPrinciples.add("un_principe_inconnu");
        selectedPrinciples.add("Storage-limitation");

        converter = new Converter(selectedPrinciples, "path", null, null, null);

        // Act
        List<String> queries = converter.ConvertToPrologQuery();

        // Assert
        assertEquals(2, queries.size());
        assertEquals("rightAccess(S, TE).", queries.get(0));
        assertEquals("storageLimitation(D, TU).", queries.get(1));
    }
}
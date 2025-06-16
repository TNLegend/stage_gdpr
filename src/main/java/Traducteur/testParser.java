package Traducteur;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class testParser {

    private File tempFile;
    private Parser parser;

    // Cette méthode crée un fichier temporaire propre avant chaque test
    @BeforeEach
    void setUp() throws IOException {
        tempFile = File.createTempFile("test_parser", ".pl");
        parser = new Parser(tempFile);
    }

    // Cette méthode supprime le fichier temporaire après chaque test
    @AfterEach
    void tearDown() {
        if (tempFile != null && tempFile.exists()) {
            tempFile.delete();
        }
    }

    private void writeToFile(String content) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            writer.write(content);
        }
    }

    @Test
    @DisplayName("parserData devrait retourner uniquement les données personnelles")
    void testParserData_OnlyPersonal() throws IOException {
        // Arrange
        String content = "wasGeneratedBy('wall_bob','create_account','personal data',15).\n" +
                "wasGeneratedBy('privacy_policy_template','create_account','policy',15).\n" +
                "wasGeneratedBy('phone_bob','create_account','personal data',15).\n";
        writeToFile(content);

        // Act
        List<String> data = parser.parserData();

        // Assert
        assertEquals(2, data.size());
        assertTrue(data.contains("wall_bob"));
        assertTrue(data.contains("phone_bob"));
        assertFalse(data.contains("privacy_policy_template"));
    }

    @Test
    @DisplayName("parserUser devrait retourner des utilisateurs uniques")
    void testParserUser_UniqueUsers() throws IOException {
        // Arrange
        String content = "wasControlledBy('create_account','Bob','owner',10,15).\n" +
                "wasControlledBy('consent','Bob','owner',16,20).\n" +
                "wasControlledBy('sendData','DC','owner', 44700, 44703).\n";
        writeToFile(content);

        // Act
        List<String> users = parser.parserUser();

        // Assert
        assertEquals(2, users.size());
        assertTrue(users.contains("Bob"));
        assertTrue(users.contains("DC"));
    }

    @Test
    @DisplayName("parserProcess devrait retourner des processus uniques")
    void testParserProcess_UniqueProcesses() throws IOException {
        // Arrange
        String content = "action('consent','consent').\n" +
                "action('update','updateConsent').\n" +
                "action('consent','consent').\n";
        writeToFile(content);

        // Act
        List<String> processes = parser.parserProcess();

        // Assert
        assertEquals(2, processes.size());
        assertTrue(processes.contains("consent"));
        assertTrue(processes.contains("update"));
    }

    @Test
    @DisplayName("Tous les parsers devraient retourner une liste vide pour un fichier vide")
    void testParsers_EmptyFile() throws IOException {
        // Arrange: le fichier est créé vide par setUp()

        // Act
        List<String> data = parser.parserData();
        List<String> users = parser.parserUser();
        List<String> processes = parser.parserProcess();

        // Assert
        assertTrue(data.isEmpty());
        assertTrue(users.isEmpty());
        assertTrue(processes.isEmpty());
    }
}
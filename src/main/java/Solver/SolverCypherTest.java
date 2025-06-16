package Solver;

import GraphDB.Neo4jInterface;
import org.junit.jupiter.api.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class SolverCypherTest {

    private Neo4jInterface neo;
    private SolverCypher solver;
    private Path tempTimeFile;

    private static final String NEO4J_URI = "bolt://localhost:7687";
    private static final String NEO4J_USER = "neo4j";
    // !! METTEZ VOTRE MOT DE PASSE NEO4J ICI !!
    private static final String NEO4J_PASSWORD = "01012002";

    @BeforeAll
    void setUpAll() throws IOException {
        neo = new Neo4jInterface();
        neo.setParameters(NEO4J_URI, NEO4J_USER, NEO4J_PASSWORD);
        solver = new SolverCypher(neo);

        tempTimeFile = Files.createTempFile("test_time_data", ".pl");
        String timeContent = """
                tCurrent(5000).
                tLimit('access', 1000).
                tLimit('erase', 1000).
                tLimit('storage', 1000).
                """;
        Files.writeString(tempTimeFile, timeContent);
    }

    @BeforeEach
    void cleanDatabase() {
        neo.executeQuery("MATCH (n) DETACH DELETE n", Collections.emptyMap());
    }

    @AfterAll
    void tearDownAll() throws IOException {
        cleanDatabase();
        Files.deleteIfExists(tempTimeFile);
    }

    private void executeQueries(String... queries) {
        for (String query : queries) {
            neo.executeQuery(query, Collections.emptyMap());
        }
    }

    @Nested
    @DisplayName("Right to Erasure Tests")
    class RightToErasureTests {

        @Test
        @DisplayName("✅ Compliant: Data is erased within the time limit")
        void testErase_Compliant_InTime() throws IOException {
            // CORRECTION: On crée UN SEUL artifact 'd1' et les deux process l'utilisent.
            executeQueries(
                    "CREATE (d1:Artifact {name:'data1'})",
                    "CREATE (:Process {action:'askErase'})-[:used {TU:100}]->(d1)",
                    "CREATE (:Process {action:'delete'})-[:used {TU:500}]->(d1)"
            );
            solver.solve(List.of("eraseCompliant"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Erasure request exists but data is never deleted")
        void testErase_NonCompliant_NotDeleted() throws IOException {
            executeQueries(
                    "CREATE (:Process {name:'p_ask_erase', action:'askErase'})-[:used {TU:100}]->(:Artifact {name:'data1'})"
            );
            solver.solve(List.of("eraseCompliant"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Data is erased after the time limit")
        void testErase_NonCompliant_DeletedTooLate() throws IOException {
            // CORRECTION: Assurer que c'est le même artifact.
            executeQueries(
                    "CREATE (d1:Artifact {name:'data1'})",
                    "CREATE (:Process {name:'p_ask_erase', action:'askErase'})-[:used {TU:100}]->(d1)",
                    "CREATE (:Process {action:'delete'})-[:used {TU:1200}]->(d1)"
            );
            solver.solve(List.of("eraseCompliant"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }
    }

    @Nested
    @DisplayName("Right to Access Tests")
    class RightToAccessTests {

        @Test
        @DisplayName("✅ Compliant: Data is sent within the time limit after a request")
        void testAccess_Compliant_SentInTime() throws IOException {
            executeQueries(
                    "CREATE (p_ask:Process {name:'p_ask', action:'askDataAccess'})-[:wasControlledBy {ctx:'owner', TE:50}]->(:Agent {name:'Alice'})",
                    "CREATE (req_A:Artifact {name:'req_A'})-[:wasGeneratedBy {TG:50}]->(p_ask)",
                    "CREATE (p_send:Process {name:'p_send', action:'sendData'})-[:used {TU:900}]->(req_A)",
                    "MATCH (p:Process {name:'p_send'}) CREATE (p)-[:wasControlledBy {TE:900}]->(:Agent {name:'System'})"
            );
            solver.solve(List.of("rightAccess"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Data is not sent after a request within the time limit")
        void testAccess_NonCompliant_NotSent() throws IOException {
            executeQueries(
                    "CREATE (p_ask:Process {name:'p_ask', action:'askDataAccess'})-[:wasControlledBy {ctx:'owner', TE:50}]->(:Agent {name:'Alice'})",
                    "CREATE (:Artifact {name:'req_A'})-[:wasGeneratedBy {TG:50}]->(p_ask)"
            );
            solver.solve(List.of("rightAccess"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }
    }

    @Nested
    @DisplayName("Storage Limitation Tests")
    class StorageLimitationTests {

        @Test
        @DisplayName("✅ Compliant: Data has not expired yet")
        void testStorage_Compliant_NotExpired() throws IOException {
            executeQueries(
                    "CREATE (d1:Artifact {name:'d1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {action:'someUse'})-[:used {TU:4500}]->(d1)"
            );
            solver.solve(List.of("storageLimitation"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("✅ Compliant: Data has expired but was already deleted")
        void testStorage_Compliant_ExpiredButDeleted() throws IOException {
            executeQueries(
                    "CREATE (d1:Artifact {name:'d1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {action:'someUse'})-[:used {TU:10}]->(d1)",
                    "CREATE (:Process {action:'delete'})-[:used {TU:2000}]->(d1)"
            );
            solver.solve(List.of("storageLimitation"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Data has expired and was not deleted")
        void testStorage_NonCompliant_ExpiredAndNotDeleted() throws IOException {
            executeQueries(
                    "CREATE (d1:Artifact {name:'d1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {action:'someUse'})-[:used {TU:10}]->(d1)"
            );
            solver.solve(List.of("storageLimitation"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }
    }

    @Nested
    @DisplayName("Consent Lawfulness Tests")
    class ConsentTests {

        @Test
        @DisplayName("✅ Compliant: Processing is done with valid and active consent")
        void testConsent_Compliant_WithValidConsent() throws IOException {
            // CORRECTION: Utiliser une variable (p1) pour référencer le même nœud.
            executeQueries(
                    "CREATE (p1:Artifact {name:'phone_1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {name:'p_send', action:'sendAd'})-[:used {TU:200}]->(p1)",
                    "CREATE (:Artifact {name:'c1', consent_type:'purposes_consent', phone_1_purposes:['sendAd']})-[:wasGeneratedBy {TG:50}]->(:Process)"
            );
            solver.solve(List.of("legal"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("✅ Compliant: Processing purpose is in default allowed list")
        void testConsent_Compliant_DefaultPurpose() throws IOException {
            // CORRECTION: Utiliser une variable (p1).
            executeQueries(
                    "CREATE (p1:Artifact {name:'phone_1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {name:'p_create', action:'createAccount'})-[:used {TU:100}]->(p1)"
            );
            solver.solve(List.of("legal"), "", tempTimeFile.toString());
            assertTrue(solver.getIssues().isEmpty());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Processing happens without any consent artifact")
        void testConsent_NonCompliant_NoConsent() throws IOException {
            // CORRECTION: Utiliser une variable (p1).
            executeQueries(
                    "CREATE (p1:Artifact {name:'phone_1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {name:'p_send', action:'sendAd'})-[:used {TU:200}]->(p1)"
            );
            solver.solve(List.of("legal"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Processing happens after consent is revoked")
        void testConsent_NonCompliant_ConsentRevoked() throws IOException {
            // CORRECTION: Utiliser des variables (p1, c1) pour lier correctement les nœuds.
            executeQueries(
                    "CREATE (p1:Artifact {name:'phone_1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (c1:Artifact {name:'c1', consent_type:'purposes_consent', phone_1_purposes:['sendAd']})-[:wasGeneratedBy {TG:50}]->(:Process)",
                    "CREATE (:Process {action:'revokeConsent'})-[:used {TU:150}]->(c1)",
                    "CREATE (:Process {name:'p_send', action:'sendAd'})-[:used {TU:300}]->(p1)"
            );
            solver.solve(List.of("legal"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }

        @Test
        @DisplayName("❌ Non-Compliant: Consent exists, but for a different purpose")
        void testConsent_NonCompliant_WrongPurpose() throws IOException {
            // CORRECTION: Utiliser une variable (p1).
            executeQueries(
                    "CREATE (p1:Artifact {name:'phone_1'})-[:wasGeneratedBy {ctx:'personal data'}]->(:Process)",
                    "CREATE (:Process {name:'p_analytics', action:'doAnalytics'})-[:used {TU:300}]->(p1)",
                    "CREATE (:Artifact {name:'c1', consent_type:'purposes_consent', phone_1_purposes:['sendAd']})-[:wasGeneratedBy {TG:50}]->(:Process)"
            );
            solver.solve(List.of("legal"), "", tempTimeFile.toString());
            assertEquals(1, solver.getIssues().size());
        }
    }
}
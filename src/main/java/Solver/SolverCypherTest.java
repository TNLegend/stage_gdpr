package Solver;

import GraphDB.Neo4jInterface;
import org.junit.jupiter.api.*;
import org.mockito.ArgumentCaptor;
import org.neo4j.driver.*;
import org.neo4j.driver.Record;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import org.neo4j.driver.TransactionContext;
import org.neo4j.driver.TransactionCallback;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Tests unitaires poussés :
 *   • on mocke Neo4jInterface
 *   • on vérifie les paramètres Cypher et la construction d’Issue
 *
 * Couverture visée : > 90 %.
 */
class SolverCypherTest {

    private Neo4jInterface neo;   // mock
    private SolverCypher   solver;
    private Path           timeFile;

    @BeforeEach
    void setUp() throws IOException {
        neo    = mock(Neo4jInterface.class);

        // ───────────────────────────────────────────────────────────────
        // M U S T - H A V E   S T U B S   F O R   getDriver() / session
        // ───────────────────────────────────────────────────────────────
        Driver   mockDriver  = mock(Driver.class);
        Session  mockSession = mock(Session.class);
        when(neo.getDriver()).thenReturn(mockDriver);
        when(mockDriver.session(any(SessionConfig.class))).thenReturn(mockSession);

        // Whenever someone does session.executeRead(tx -> neo.runReadQuery(tx, …)),
        // we capture that lambda, hand it a fake TransactionContext, and
        // tell neo.runReadQuery(...) to delegate to the existing neo.executeQuery(...)
        when(mockSession.executeRead(any(TransactionCallback.class)))
                .thenAnswer(invocation -> {
                    @SuppressWarnings("unchecked")
                    TransactionCallback<List<Record>> callback = invocation.getArgument(0);
                    // In 5.x the callback gets a Transaction (which extends TransactionContext)
                    TransactionContext fakeTx = mock(TransactionContext.class);
                    // Make neo.runReadQuery(fakeTx,…) delegate to neo.executeQuery(…)
                    when(neo.runReadQuery(eq(fakeTx), anyString(), anyMap()))
                            .thenAnswer(inner -> {
                                String cypher = inner.getArgument(1);
                                @SuppressWarnings("unchecked")
                                Map<String,Object> params = inner.getArgument(2);
                                return neo.executeQuery(cypher, params);
                            });
                    // execute the callback
                    return callback.execute(fakeTx);
                });
        // ───────────────────────────────────────────────────────────────

        solver = new SolverCypher(neo);

        // … the rest of your existing setUp …
        timeFile = Files.createTempFile("times", ".pl");
        Files.writeString(timeFile, """
            tCurrent(5000).
            tLimit('access', 1000).
            tLimit('erase',  1000).
            tLimit('storage',1000).
            """);
    }

    /* ---------------------------------------------------- */
    /* ----------------  aides de test -------------------- */
    /* ---------------------------------------------------- */

    /** Construit un Record Mockito dont les colonnes renvoient les Value voulues. */
    private Record mockRecord(Map<String, Object> data) {
        Record rec = mock(Record.class);
        data.forEach((k, v) -> when(rec.get(k)).thenReturn(Values.value(v)));
        return rec;
    }

    /** Récupère la dernière requête Cypher transmise au mock. */
    private String captureLastQuery() {
        ArgumentCaptor<String> cap = ArgumentCaptor.forClass(String.class);
        verify(neo, atLeastOnce()).executeQuery(cap.capture(), anyMap());
        return cap.getValue();
    }

    /* ---------------------------------------------------- */
    /* ------------  TESTS PAR PRINCIPE GDPR -------------- */
    /* ---------------------------------------------------- */

    @Nested @DisplayName("Right to Erasure")
    class Erasure {

        @Test @DisplayName("✅ conforme – aucun résultat → 0 issue")
        void compliant() throws IOException {
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(Collections.emptyList());

            String res = solver.solve(
                    List.of("eraseCompliant"), "", timeFile.toString());

            assertTrue(solver.getIssues().isEmpty());
            assertEquals("System is compliant.", res.strip());
            assertTrue(captureLastQuery().contains("askErase"));
        }

        @Test @DisplayName("❌ non-conforme – 1 résultat → 1 issue")
        void nonCompliant() throws IOException {
            Record rec = mockRecord(Map.of("D", "data1", "T", 120, "P", "p1"));
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(List.of(rec));

            solver.solve(List.of("eraseCompliant"), "", timeFile.toString());

            assertEquals(1, solver.getIssues().size());
        }
    }

    @Nested @DisplayName("Right to Access")
    class Access {

        @Test @DisplayName("✅ conforme – 0 issue")
        void compliant() throws IOException {
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(Collections.emptyList());

            solver.solve(List.of("rightAccess"), "", timeFile.toString());

            assertTrue(solver.getIssues().isEmpty());
        }

        @Test @DisplayName("❌ non-conforme – 1 issue")
        void nonCompliant() throws IOException {
            Record rec = mockRecord(Map.of("S", "Alice", "TE", 50));
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(List.of(rec));

            solver.solve(List.of("rightAccess"), "", timeFile.toString());

            assertEquals(1, solver.getIssues().size());
        }
    }

    @Nested @DisplayName("Storage Limitation")
    class Storage {

        @Test @DisplayName("✅ conforme")
        void compliant() throws IOException {
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(Collections.emptyList());

            solver.solve(List.of("storageLimitation"), "", timeFile.toString());

            assertTrue(solver.getIssues().isEmpty());
        }

        @Test @DisplayName("❌ non-conforme – 2 issues")
        void nonCompliant() throws IOException {
            Record r1 = mockRecord(Map.of("D", "d1", "TU", 10));
            Record r2 = mockRecord(Map.of("D", "d2", "TU", 20));
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(List.of(r1, r2));

            solver.solve(List.of("storageLimitation"), "", timeFile.toString());

            assertEquals(2, solver.getIssues().size());
        }
    }

    @Nested @DisplayName("Lawfulness / Consent")
    class Consent {

        @Test @DisplayName("✅ but par défaut autorisé → conforme")
        void defaultPurpose_compliant() throws IOException {
            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(Collections.emptyList());

            solver.solve(List.of("legal"), "", timeFile.toString());

            assertTrue(solver.getIssues().isEmpty());
        }

        @Test @DisplayName("❌ consentement révoqué → non-conforme")
        void revokedConsent_nonCompliant() throws IOException {
            Record rec = mockRecord(Map.of(
                    "P", "p_send",
                    "D_used", "phone_1",
                    "PU", "sendAd",
                    "T", 300));

            when(neo.executeQuery(anyString(), anyMap()))
                    .thenReturn(List.of(rec));

            solver.solve(List.of("legal"), "", timeFile.toString());

            assertEquals(1, solver.getIssues().size());
        }
    }

    /* ---------------------------------------------------- */
    /* -----  Vérification des méthodes utilitaires  ------ */
    /* ---------------------------------------------------- */

    @Test @DisplayName("parseTimeFile lit correctement les 4 constantes")
    void parseTimeFile_ok()
            throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, IOException {

        Method mParse = SolverCypher.class
                .getDeclaredMethod("parseTimeFile", String.class);
        mParse.setAccessible(true);

        @SuppressWarnings("unchecked")
        Map<String, Object> map =
                (Map<String, Object>) mParse.invoke(solver, timeFile.toString());

        assertEquals(5000, map.get("currentTime"));
        assertEquals(1000, map.get("accessLimitDuration"));
        assertEquals(1000, map.get("erasureLimitDuration"));
        assertEquals(1000, map.get("storageLimitDuration"));
    }

    @Test @DisplayName("extractValue extrait bien la valeur entière")
    void extractValue_various()
            throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {

        Method meth = SolverCypher.class
                .getDeclaredMethod("extractValue", String.class);
        meth.setAccessible(true);

        assertEquals("123", meth.invoke(solver, "tCurrent(123)."));
        assertEquals("456", meth.invoke(solver, "tLimit('access',456)."));
    }
}

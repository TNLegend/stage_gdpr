package Interface.ter;

import GraphDB.Neo4jInterface;
import Solver.*; // CHANGEMENT : Importer toutes nos nouvelles classes (SolverInterface, PrologSolver, etc.)
import Traducteur.Converter;
import Traducteur.Parser;
import com.sun.javafx.collections.ObservableListWrapper; // Note: cet import est déprécié, préférez FXCollections.observableArrayList
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.ComboBoxListCell;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.scene.web.WebView;
import javafx.scene.web.WebEngine;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javafx.concurrent.Worker;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;

public class ScreenController {
    // --- CHAMPS DE LA CLASSE (INCHANGÉS) ---
    private HashMap<String, Pane> screenMap = new HashMap<>();
    private File graph;
    private File timeFile;
    private Scene main;
    private SolveController solveController = new SolveController();
    private FileChooser fileChooser = new FileChooser();
    private Stage fileChooserStage = new Stage();
    private Neo4jInterface neo = null;
    private String nextScreen;
    private String previousScreen;

    // --- MÉTHODES D'INITIALISATION ET DE NAVIGATION (INCHANGÉES) ---
    public void init() {
        initGraphPathScreen();
        initTimesHelpScreen();
    }

    public void setMainScene(Scene scene) {
        this.main = scene;
    }

    public void initGraphPathScreen() {
        graph = null;
        timeFile = null;
        neo = null;
        VBox graphPathScreen = new VBox(10);
        graphPathScreen.setPadding(new Insets(20, 20, 20, 20));
        Label fileLabel = new Label("Provide the Prolog provenance graph file path:");
        TextField filePathField = new TextField();
        filePathField.setPromptText("Provenance graph file path");
        Button openGraphFile = new Button("Open...");
        openGraphFile.setOnAction(event -> {
            fileChooser.setTitle("Select the graph provenance file");
            File selectedFile = fileChooser.showOpenDialog(fileChooserStage);
            if (selectedFile != null) {
                filePathField.setText(selectedFile.getAbsolutePath());
            }
        });
        Button submitGraphPath = new Button("Submit");
        submitGraphPath.setStyle("-fx-background-color: #13A0EB; -fx-text-fill: white;");
        submitGraphPath.setOnAction(event -> {
            String path = filePathField.getText();
            File graphFile = new File(path);
            if (graphFile.isFile()) {
                this.graph = graphFile;
                try {
                    initChoiceScreen();
                } catch (IOException e) {
                    filePathField.clear();
                    graphPathScreen.getChildren().add(new Text("File opening error: " + e.getMessage()));
                }
                activate("choiceScreen");
            } else {
                graphPathScreen.getChildren().removeIf(s -> s instanceof Text);
                filePathField.clear();
                graphPathScreen.getChildren().add(new Text("File not found"));
            }
        });
        Button neoImport = new Button("Import from Neo4J");
        neoImport.setOnAction(event -> {
            nextScreen = "choiceScreen";
            previousScreen = "graphPathScreen";
            initNeo4jLogInScreen();
            activate("neo4jLogInScreen");
        });
        graphPathScreen.getChildren().addAll(fileLabel, filePathField, openGraphFile, submitGraphPath, neoImport);
        screenMap.put("graphPathScreen", graphPathScreen);
    }

    /**
     * MODIFIÉ : Refactorisation complète pour intégrer le choix du solveur et clarifier la logique.
     */
    public void initChoiceScreen() throws IOException {
        VBox choiceVBox = new VBox(10);
        choiceVBox.setPadding(new Insets(10));

        // --- SECTION FICHIER DE TEMPS ---
        Label timeFileLabel = new Label("Provide time data file path:");
        TextField timeFilePathField = new TextField(timeFile != null ? timeFile.getPath() : "");
        timeFilePathField.setPromptText("Time data file path");
        Button openTimeFile = new Button("Open...");
        openTimeFile.setOnAction(event -> {
            fileChooser.setTitle("Select time data file");
            File selectedFile = fileChooser.showOpenDialog(fileChooserStage);
            if (selectedFile != null) {
                timeFilePathField.setText(selectedFile.getAbsolutePath());
            }
        });
        Button redirectToHelp = new Button("Help");
        redirectToHelp.setOnAction(e -> activate("timesHelpScreen"));
        choiceVBox.getChildren().addAll(timeFileLabel, timeFilePathField, openTimeFile, redirectToHelp);

        // --- SECTION CHOIX DES PRINCIPES ---
        Label principlesLabel = new Label("Select the principles to check:");
        CheckBox principle1 = new CheckBox("Lawfulness of processing (consent compliance)");
        CheckBox principle2 = new CheckBox("Right to erase");
        CheckBox principle3 = new CheckBox("Right to access");
        CheckBox principle4 = new CheckBox("Storage limitation");
        choiceVBox.getChildren().addAll(new Separator(), principlesLabel, principle1, principle2, principle3, principle4);

        // --- AJOUT : CHOIX DU SOLVEUR ---
        Label solverLabel = new Label("Choose the solver engine:");
        ComboBox<String> solverChoiceBox = new ComboBox<>();
        solverChoiceBox.getItems().addAll("Prolog Solver", "Cypher Solver");
        solverChoiceBox.setValue("Prolog Solver");
        choiceVBox.getChildren().addAll(new Separator(), solverLabel, solverChoiceBox);
        // On ajoute un "écouteur" qui réagit au changement de sélection
        solverChoiceBox.valueProperty().addListener((obs, oldVal, newVal) -> {
            if ("Cypher Solver".equals(newVal) && this.neo == null) {
                // Si l'utilisateur choisit Cypher et n'est pas connecté, on le redirige
                Alert alert = new Alert(Alert.AlertType.INFORMATION, "The Cypher solver requires a Neo4j connection. Please log in.");
                alert.setHeaderText("Neo4j Connection Required");
                alert.showAndWait();

                // On prépare la navigation
                nextScreen = "choiceScreen"; // Pour revenir ici après la connexion
                previousScreen = "choiceScreen";
                initNeo4jLogInScreen();
                activate("neo4jLogInScreen");
            }
        });

        // --- BOUTON DE SOUMISSION ---
        Button submitButton = new Button("Check principles");
        submitButton.setStyle("-fx-background-color: #3498db; -fx-text-fill: white;");
        submitButton.setOnAction(e -> {
            File timeFile = new File(timeFilePathField.getText());
            if (!timeFile.isFile()) {
                new Alert(Alert.AlertType.ERROR, "Time data file not found.").showAndWait();
                return;
            }
            this.timeFile = timeFile;

            SolverInterface solver; // On utilise l'interface
            if ("Prolog Solver".equals(solverChoiceBox.getValue())) {
                solver = new PrologSolver();
            } else {
                if (this.neo == null) {
                    new Alert(Alert.AlertType.ERROR, "Please connect to Neo4j first to use the Cypher solver.").showAndWait();
                    return;
                }
                neo.retrieveGraphDB(graph.getAbsolutePath());
                solver = new SolverCypher(this.neo);
            }

            ArrayList<String> selectedPrinciples = new ArrayList<>();
            if (principle1.isSelected()) selectedPrinciples.add(Issue.IssueType.LEGAL.typeName);
            if (principle2.isSelected()) selectedPrinciples.add(Issue.IssueType.RIGHT_TO_ERASURE.typeName);
            if (principle3.isSelected()) selectedPrinciples.add(Issue.IssueType.RIGHT_TO_ACCESS.typeName);
            if (principle4.isSelected()) selectedPrinciples.add(Issue.IssueType.STORAGE_LIMITATION.typeName);
            if (selectedPrinciples.isEmpty()) {
                selectedPrinciples.addAll(List.of(Issue.IssueType.LEGAL.typeName, Issue.IssueType.RIGHT_TO_ERASURE.typeName, Issue.IssueType.RIGHT_TO_ACCESS.typeName, Issue.IssueType.STORAGE_LIMITATION.typeName));
            }

            // Le Converter n'est plus utile pour le SolveController mais peut l'être pour d'autres parties
            // Pour l'instant on le laisse de côté pour la résolution.
            solveController.setSolver(solver);

            try {
                // On exécute la résolution. Le contrôleur ne se soucie pas de l'implémentation.
                String resultsText = solver.solve(selectedPrinciples, this.graph.getAbsolutePath(), this.timeFile.getAbsolutePath());
                initResultsScreen(solver.getIssues(), resultsText);
                activate("resultsScreen");
            } catch (Exception err) {
                new Alert(Alert.AlertType.ERROR, "An error occurred during solving: " + err.getMessage()).showAndWait();
                err.printStackTrace();
            }
        });

        // --- MISE EN PAGE FINALE DE L'ÉCRAN ---
        // NOTE: Le code des options avancées est complexe et spécifique à votre parser.
        // Il doit être inséré dans le `choiceVBox` si vous souhaitez le conserver.
        ScrollPane scroll = new ScrollPane(choiceVBox);
        scroll.setFitToWidth(true);
        Button returnBtn = new Button("Previous");
        returnBtn.setOnAction(e -> activate("graphPathScreen"));
        HBox buttonBar = new HBox(10, submitButton, returnBtn);
        VBox mainLayout = new VBox(10, scroll, buttonBar);
        mainLayout.setPadding(new Insets(10));

        screenMap.put("choiceScreen", mainLayout);
    }


    /**
     * Initialises the Neo4J login screen, where the user is invited to put credentials to access the GraphDB.
     */
    public void initNeo4jLogInScreen() {
        VBox neo4jLogInScreen = new VBox(10);
        neo4jLogInScreen.setPadding(new Insets(20, 20, 20, 20));

        /* ── form controls ─────────────────────────────────────── */
        Label uriLbl  = new Label("Database URI");
        Label userLbl = new Label("User");
        Label pwdLbl  = new Label("Password");

        TextField     uriField  = new TextField();
        TextField     userField = new TextField();
        PasswordField pwdField  = new PasswordField();

        uriField.setPromptText("bolt://localhost:7687");
        userField.setPromptText("neo4j");                 // ← fixed typo
        pwdField.setPromptText("••••••");

        Button backBtn = new Button("Previous");
        Button loadBtn = new Button("Load");

        backBtn.setOnAction(e -> activate(previousScreen));

        /* ── load button logic ─────────────────────────────────── */
        loadBtn.setOnAction(e -> {
        /* ------------------------------------------------------------------
           1.  Build a proper URI (add bolt:// if missing, trim blanks)
         ------------------------------------------------------------------ */
            String uriText = uriField.getText().trim();
            if (!uriText.startsWith("bolt://") &&
                    !uriText.startsWith("neo4j://") &&
                    !uriText.startsWith("bolt+s://") &&
                    !uriText.startsWith("neo4j+s://"))
            {
                uriText = "bolt://" + uriText;
            }

        /* ------------------------------------------------------------------
           2.  Prepare helper + flags
         ------------------------------------------------------------------ */
            neo = new Neo4jInterface();
            neo.setParameters(uriText, userField.getText().trim(), pwdField.getText());
            pwdField.clear();

            boolean cypherLogin =
                    "choiceScreen".equals(nextScreen) &&
                            "choiceScreen".equals(previousScreen);

            try {
            /* ------------------------------------------------------------------
               3.  Always verify credentials first so we fail fast
             ------------------------------------------------------------------ */
                try (var drv = org.neo4j.driver.GraphDatabase.driver(
                        uriText,
                        org.neo4j.driver.AuthTokens.basic(userField.getText().trim(),
                                neo.getPassword())))
                {
                    drv.verifyConnectivity();          // throws on bad creds / URI
                }

            /* ------------------------------------------------------------------
               4.  Branch-specific behaviour
             ------------------------------------------------------------------ */
                if ("graphVizScreen".equals(nextScreen)) {
                    /* Visualisation flow */
                    System.out.println("Loading provenance graph from " + graph.getPath());
                    neo.retrieveGraphDB(graph.getAbsolutePath());
                    initGraphVizScreen("MATCH (n)-[r]->(m) RETURN *");

                } else if (!cypherLogin) {
                    /* “Import from Neo4j” flow */
                    neo.retrievePrologPG();
                    File pg = new File(neo.generatedPrologGraphPath);
                    if (pg.isFile()) {
                        this.graph = pg;
                        initChoiceScreen();
                    }
                }
                activate(nextScreen);

            } catch (org.neo4j.driver.exceptions.AuthenticationException ex) {
                new Alert(Alert.AlertType.ERROR,
                        "Authentication failed – please check user name / password.")
                        .showAndWait();

            } catch (org.neo4j.driver.exceptions.ServiceUnavailableException ex) {
                new Alert(Alert.AlertType.ERROR,
                        "Cannot reach Neo4j at \"" + uriText +
                                "\".  Make sure the DB is running and the port is correct.")
                        .showAndWait();

            } catch (Exception ex) {
                new Alert(Alert.AlertType.ERROR,
                        "Neo4j operation failed:\n" + ex.getMessage())
                        .showAndWait();
                ex.printStackTrace();
            }
        });

        /* ── assemble ──────────────────────────────────────────── */
        neo4jLogInScreen.getChildren().addAll(
                uriLbl,  uriField,
                userLbl, userField,
                pwdLbl,  pwdField,
                loadBtn, backBtn
        );
        screenMap.put("neo4jLogInScreen", neo4jLogInScreen);
    }


    /**
     * Initialises a screen with hints on the time data file structure required.
     */
    public void initTimesHelpScreen() {
        VBox timesHelpScreen = new VBox(10);
        timesHelpScreen.setPadding(new Insets(20, 20, 20, 20));

        Label helpText = new Label("Time data file contains time limits (maximum allowed delay for erasing, sending and retaining unused data) and the time at which the verification occurs.\nThe file respects the following format :");
        helpText.setWrapText(true);
        Label format = new Label("tCurrent(<Time>).\n" +
                "tLimit('access',<Time>).\n" +
                "tLimit('erase',<Time>).\n" +
                "tLimit('storage',<Time>).");
        format.setWrapText(true);

        Button returnButton = new Button("Previous");
        returnButton.setOnAction(e -> {
            activate("choiceScreen");
        });

        timesHelpScreen.getChildren().addAll(helpText, format, returnButton);
        screenMap.put("timesHelpScreen", timesHelpScreen);

    }

    /**
     * MODIFIÉ : Propose maintenant deux options de visualisation pour un flux cohérent.
     * @param issues La liste des objets Issue générée par le solveur.
     * @param resultsText La chaîne de caractères brute retournée par le solveur (pour le cas "OK").
     */
    public void initResultsScreen(List<Issue> issues, String resultsText) {
        VBox resultsVBox = new VBox(10);
        resultsVBox.setPadding(new Insets(20, 20, 20, 20));
        Label label = new Label("Results:");

        ListView<Issue> listView = new ListView<>();
        // On rend la liste non-éditable mais sélectionnable
        listView.setEditable(false);

        if (issues.isEmpty()) {
            listView.getItems().add(null);
            listView.setCellFactory(lv -> new ListCell<>() {
                @Override
                protected void updateItem(Issue item, boolean empty) {
                    super.updateItem(item, empty);
                    setText(empty ? null : resultsText);
                }
            });
        } else {
            // On utilise la méthode de rendu toString() que nous avons définie dans la classe Issue
            listView.setItems(FXCollections.observableArrayList(issues));
        }

        // --- CHANGEMENT : DEUX BOUTONS DE VISUALISATION ---

        // 1. Bouton pour voir le graphe complet
        // --- NOUVELLE LOGIQUE POUR LE BOUTON ---
        Button visualizeFullGraphBtn = new Button("Visualize Full Graph");
        visualizeFullGraphBtn.setOnAction(e -> {
            previousScreen = "resultsScreen";

            if (neo == null) {
                // Si pas de connexion, on demande à l'utilisateur de se connecter
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "A Neo4j connection is required. This will load the current provenance graph into the database. Continue?", ButtonType.YES, ButtonType.NO);
                alert.showAndWait();

                if (alert.getResult() == ButtonType.YES) {
                    nextScreen = "graphVizScreen"; // La destination après la connexion
                    initNeo4jLogInScreen(); // On prépare l'écran de connexion
                    activate("neo4jLogInScreen"); // On l'active
                }
            } else {
                // Si on est déjà connecté (par exemple, après un run du Cypher Solver),
                // on charge simplement le graphe et on l'affiche
                System.out.println("Reloading full graph into Neo4j for visualization...");
                neo.retrieveGraphDB(this.graph.getAbsolutePath());
                initGraphVizScreen("MATCH (n)-[r]->(m) RETURN n,r,m"); // On limite pour la performance
                activate("graphVizScreen");
            }
        });

        // 2. Bouton pour voir le détail d'une issue sélectionnée
        Button visualizeIssueBtn = new Button("Visualize Selected Issue");
        visualizeIssueBtn.setOnAction(e -> {
            Issue selectedIssue = listView.getSelectionModel().getSelectedItem();
            if (selectedIssue != null) {
                previousScreen = "resultsScreen";
                initGraphVizScreen(selectedIssue.toCypherQuery());
                activate("graphVizScreen");
            } else {
                new Alert(Alert.AlertType.INFORMATION, "Please select an issue from the list first.").showAndWait();
            }
        });
        // Le bouton de détail n'est activé que s'il y a des violations
        visualizeIssueBtn.setDisable(issues.isEmpty());

        Button newVerifBtn = new Button("New Compliance Checking");
        newVerifBtn.setOnAction(e -> {
            try {
                initChoiceScreen();
                activate("choiceScreen");
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        });

        // On ajoute les boutons dans une HBox pour un meilleur agencement
        HBox buttonBar = new HBox(10, visualizeFullGraphBtn, visualizeIssueBtn, newVerifBtn);

        resultsVBox.getChildren().addAll(label, listView, buttonBar);
        screenMap.put("resultsScreen", resultsVBox);
    }

    /**
     * Exécute une requête Cypher et imprime ses résultats bruts dans la console.
     * @param query La requête à exécuter pour le débogage.
     */
    private void printQueryResultsToConsole(String query) {
        System.out.println("\n-------------------------------------------------");
        System.out.println("--- DEBUGGING SUBGRAPH DATA IN CONSOLE ---");
        System.out.println("Query: " + query);

        try {
            if (neo == null) {
                System.out.println("--> Neo4j connection not available. Cannot fetch data for console.");
                return;
            }

            // Exécute la requête pour récupérer les données
            List<org.neo4j.driver.Record> records = neo.executeQuery(query, Collections.emptyMap());

            if (records.isEmpty()) {
                System.out.println("--> Query returned no results for console display.");
            } else {
                System.out.println("--> Query Results (" + records.size() + " rows found):");
                int recordCounter = 1;
                for (org.neo4j.driver.Record record : records) {
                    System.out.println("    [Record " + recordCounter++ + "]");
                    record.fields().forEach(field -> {
                        String key = field.key();
                        Object value = field.value().asObject();
                        System.out.println(String.format("      - %s: %s", key, value));
                    });
                }
            }
        } catch (Exception e) {
            System.err.println("Error during console debug query execution: " + e.getMessage());
        } finally {
            System.out.println("-------------------------------------------------\n");
        }
    }




    /**
     * Initialises the graph visualisation screen. The display comes from an HTML page generated according to the visualisation needs :
     * the query tells which elements of the GraphDB should be displayed.
     * @param query CYPHER query stating the GraphDB elements to display
     */
    public void initGraphVizScreen(String query) {
        printQueryResultsToConsole(query);
        VBox graphVizScreen = new VBox(10);
        graphVizScreen.setPadding(new Insets(20, 20, 20, 20));
        HBox graphVizAndIssuesScreen = new HBox(10);

        WebView webView = new WebView();
        WebEngine webEngine = webView.getEngine();

        // 1. On génère le fichier HTML "squelette" SANS les identifiants
        neo.buildVizHtmlFile(query);
        String url = Objects.requireNonNull(getClass().getResource("/index.html")).toExternalForm();

        // 2. On ajoute un "écouteur" qui attend que la page soit complètement chargée
        webEngine.getLoadWorker().stateProperty().addListener(
                (obs, oldState, newState) -> {
                    // 3. Quand la page est prête (état SUCCEEDED)...
                    if (newState == Worker.State.SUCCEEDED) {
                        System.out.println("[DEBUG] WebView loaded. Injecting credentials and calling draw().");
                        // ... on exécute notre fonction Javascript en lui passant les identifiants
                        String script = String.format("draw('%s', '%s', '%s');",
                                neo.getUri(), neo.getUser(), neo.getPassword());
                        webEngine.executeScript(script);
                    }
                }
        );

        // 4. On charge la page HTML (qui attendra notre appel de script)
        webEngine.load(url);

        // Le reste de votre logique pour afficher la liste des issues reste identique
        if (previousScreen.equals("resultsScreen")) {
            ObservableList<Issue> issues = FXCollections.observableArrayList(solveController.getSolver().getIssues());
            final ListView<Issue> listView = new ListView<>(issues);
            listView.setPrefSize(400, 450);

            // Votre code pour le bouton Reload reste valide
            Button reloadButton = new Button("Reload for Selected Issue");
            reloadButton.setOnAction(e -> {
                Issue issue = listView.getSelectionModel().getSelectedItem();
                if (issue != null) {
                    String cypher = issue.toCypherQuery();
                    neo.buildVizHtmlFile(cypher); // Regénère le HTML avec la nouvelle requête
                    webEngine.reload(); // Recharge la page, ce qui redéclenchera l'écouteur
                }
            });
            VBox issuesScreen = new VBox(10, listView, reloadButton);
            graphVizAndIssuesScreen.getChildren().add(issuesScreen);
        }

        Button returnButton = new Button("Previous");
        returnButton.setOnAction(e -> activate(previousScreen));

        graphVizAndIssuesScreen.getChildren().add(webView);
        graphVizScreen.getChildren().addAll(graphVizAndIssuesScreen, returnButton);
        screenMap.put("graphVizScreen", graphVizScreen);
    }

    /**
     * Displays a screen.
     * @param name Screen name (the one under which the screen was put to the screenMap)
     */
    public void activate(String name) { main.setRoot(screenMap.get(name)); }

    public Pane getBasePane() { return screenMap.get("graphPathScreen"); }
}
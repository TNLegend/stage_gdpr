package Interface.ter;

import GraphDB.Neo4jInterface;
import Solver.Solver;
import Traducteur.Converter;
import Traducteur.Parser;
import com.sun.javafx.collections.ObservableListWrapper;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

import static com.sun.javafx.scene.control.skin.Utils.getResource;
import Solver.Issue;


public class ScreenController {
    private HashMap<String, Pane> screenMap = new HashMap<>();
    private File graph;
    private File timeFile;
    private Scene main;

    private SolveController solveController = new SolveController();
    FileChooser fileChooser = new FileChooser();
    Stage fileChooserStage = new Stage();

    private Neo4jInterface neo = null;

    String nextScreen;
    String previousScreen;

    /**
     * Initializes the first screen and the times help screen (which only needs to be generated once)
     */
    public void init() {
        initGraphPathScreen();
        initTimesHelpScreen();
    }

    public void setMainScene(Scene scene) {
        main = scene;
    }

    /**
     * Initialises the screen asking the user to provide the path to the Prolog provenance graph file.
     */
    public void initGraphPathScreen() {
        graph = null;
        timeFile = null;
        neo = null;

        VBox graphPathScreen = new VBox(10);
        graphPathScreen.setPadding(new Insets(20, 20, 20, 20));


        // title
        Label fileLabel = new Label("Provide the Prolog provenance graph file path:");

        // provenance graph path
        TextField filePathField = new TextField();
        filePathField.setPromptText("Provenance graph file path");

        Button openGraphFile = new Button("Open...");
        openGraphFile.setOnAction(event -> {
            fileChooser.setTitle("Select the graph provenance file");
            File graph = fileChooser.showOpenDialog(fileChooserStage);
            if (graph != null) {
                filePathField.setText(graph.getAbsolutePath());
            }
        });

        Button submitGraphPath = new Button("Submit");
        submitGraphPath.setStyle("-fx-background-color: #13A0EB; -fx-text-fill: white; ");
        submitGraphPath.setOnAction(event -> {

            String path = filePathField.getText();

            File graph = new File(path);
            if (graph.isFile()) {
                this.graph = graph;
                try {
                    initChoiceScreen();
                } catch (IOException e) {
                    filePathField.clear();
                    Text error = new Text("File opening error");
                    graphPathScreen.getChildren().add(error);
                }
                activate("choiceScreen");
            } else {
                graphPathScreen.getChildren().removeIf(s -> {
                    if (s instanceof Text s1) {
                        return s1.getText().equals("File not found");
                    }
                    return false;
                });
                filePathField.clear();
                Text error = new Text("File not found");
                graphPathScreen.getChildren().add(error);
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
     * Initialises the screen asking the user to choose the verification parameters (GDPR principles, users, process, agents).
     * Also asks for the time data file path. This screen also allows choosing to visualize the whole provenance graph through a GraphDB.
     * @throws IOException In case of graph provenance file opening issue
     */
    public void initChoiceScreen() throws IOException {
        ScrollPane scroll = new ScrollPane();
        VBox choiceScreen = new VBox(10);
        choiceScreen.setPadding(new Insets(20, 20, 20, 20));

        Label timeFileLabel = new Label("Provide time data file path");
        //Label timeFileLabel = new Label("Provide system file path");
        TextField timeFilePathField;
        if (timeFile != null) {
            timeFilePathField = new TextField(timeFile.getPath());
        } else {
            timeFilePathField = new TextField();
        }

        timeFilePathField.setPromptText("Time data file path");
//        timeFilePathField.setPromptText("System file path");

        Button openTimeFile = new Button("Open...");
        openTimeFile.setOnAction(event -> {
            fileChooser.setTitle("Select time data file");
            File graph = fileChooser.showOpenDialog(fileChooserStage);
            if (graph != null) {
                timeFilePathField.setText(graph.getAbsolutePath());
            }
        });

        Button redirectToHelp = new Button("Help");
        redirectToHelp.setOnAction(e -> {
            activate("timesHelpScreen");
        });
        choiceScreen.getChildren().addAll(timeFileLabel, timeFilePathField, openTimeFile, redirectToHelp);

        Parser parser = new Parser(graph);

        ArrayList<String> selectedPrinciples = new ArrayList<>();
        String graphPath = graph.getAbsolutePath();


        Label principlesLabel = new Label("Select the principles to check");

        // Les checkbox
        CheckBox principle1 = new CheckBox("Lawfulness of processing (consent compliance)");
        CheckBox principle2 = new CheckBox("Right to erase");
        CheckBox principle3 = new CheckBox("Right to access");
        CheckBox principle4 = new CheckBox("Storage limitation");

        Label advancedOptionsInfo = new Label("[optional] If needed, please specify personal data, processes or users to check to narrow the scope");
        choiceScreen.getChildren().addAll(principlesLabel, principle1, principle2, principle3, principle4, advancedOptionsInfo);

        VBox dataOptionsContent = new VBox(10);

        Label datasLabel = new Label("[optional] Specify a personal data to check");
        dataOptionsContent.getChildren().add(datasLabel);

        List<String> datas = parser.parserData();

        ArrayList<CheckBox> datasBoxes = new ArrayList<>();
        if (datas.isEmpty()) {
            dataOptionsContent.getChildren().add(new Text("No available data"));
        } else {
            for (String d : datas) {

                CheckBox dataBtn = new CheckBox(d);
                dataBtn.setMnemonicParsing(false);     //if true the first underscore doesn't show up
                datasBoxes.add(dataBtn);
                dataOptionsContent.getChildren().add(dataBtn);
            }
        }

        Button showDataOptions = new Button(" Show personal data options ");
        Button hideDataOptions = new Button(" Hide personal data options ");

        VBox hiddenDataOptions = new VBox(0);

        showDataOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(showDataOptions);
            choiceScreen.getChildren().add(10, hideDataOptions);
            choiceScreen.getChildren().remove(hiddenDataOptions);
            choiceScreen.getChildren().add(11, dataOptionsContent);
        });

        hideDataOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(hideDataOptions);
            choiceScreen.getChildren().add(10, showDataOptions);
            choiceScreen.getChildren().remove(dataOptionsContent);
            choiceScreen.getChildren().add(11, hiddenDataOptions);
        });

        choiceScreen.getChildren().add(showDataOptions);
        choiceScreen.getChildren().add(hiddenDataOptions);


        VBox usersOptionsContent = new VBox(10);

        Label usersLabel = new Label("[optional] Specify a user to check");
        usersOptionsContent.getChildren().add(usersLabel);

        List<String> users = parser.parserUser();
        ArrayList<CheckBox> usersBoxes = new ArrayList<>();
        if (users.isEmpty()) {
            usersOptionsContent.getChildren().add(new Text("No available user"));
        } else {
            for (String u : users) {
                CheckBox userBtn = new CheckBox(u);
                userBtn.setMnemonicParsing(false);
                usersBoxes.add(userBtn);
                usersOptionsContent.getChildren().add(userBtn);
            }
        }

        Button showUsersOptions = new Button(" Show users options ");
        Button hideUsersOptions = new Button(" Hide users options ");

        VBox hiddenUsersOptions = new VBox(0);

        showUsersOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(showUsersOptions);
            choiceScreen.getChildren().add(12, hideUsersOptions);
            choiceScreen.getChildren().remove(hiddenUsersOptions);
            choiceScreen.getChildren().add(13, usersOptionsContent);
        });

        hideUsersOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(hideUsersOptions);
            choiceScreen.getChildren().add(12, showUsersOptions);
            choiceScreen.getChildren().remove(usersOptionsContent);
            choiceScreen.getChildren().add(13, hiddenUsersOptions);
        });

        choiceScreen.getChildren().add(showUsersOptions);
        choiceScreen.getChildren().add(hiddenUsersOptions);

        VBox processesOptionsContent = new VBox(10);

        Label processLabel = new Label("[optional] Specify a process to check");
        processesOptionsContent.getChildren().add(processLabel);
        List<String> processes = parser.parserProcess();
        ArrayList<CheckBox> processesBoxes = new ArrayList<>();
        if (processes.isEmpty()) {
            processesOptionsContent.getChildren().add(new Text("No available process"));
        } else {
            for (String p : processes) {
                CheckBox processBtn = new CheckBox(p);
                processBtn.setMnemonicParsing(false);
                processesBoxes.add(processBtn);
                processesOptionsContent.getChildren().add(processBtn);
            }
        }

        Button showProcessesOptions = new Button(" Show processes options ");
        Button hideProcessesOptions = new Button(" Hide processes options ");

        VBox hiddenProcessesOptions = new VBox(0);

        showProcessesOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(showProcessesOptions);
            choiceScreen.getChildren().add(14, hideProcessesOptions);
            choiceScreen.getChildren().remove(hiddenProcessesOptions);
            choiceScreen.getChildren().add(15, processesOptionsContent);
        });

        hideProcessesOptions.setOnAction(event -> {
            choiceScreen.getChildren().remove(hideProcessesOptions);
            choiceScreen.getChildren().add(14, showProcessesOptions);
            choiceScreen.getChildren().remove(processesOptionsContent);
            choiceScreen.getChildren().add(15, hiddenProcessesOptions);
        });

        choiceScreen.getChildren().add(showProcessesOptions);
        choiceScreen.getChildren().add(hiddenProcessesOptions);

        Button submitButton = new Button(" Check principles ");
        submitButton.setStyle("-fx-background-color: #3498db; -fx-text-fill: white;");
        submitButton.setOnAction(e -> {

            Solver solver = new Solver();
            String timePath = timeFilePathField.getText();

            File timeFile = new File(timePath);

            if (!timeFile.isFile()) {
                timeFilePathField.clear();
                Text error = new Text("File not found");
                choiceScreen.getChildren().add(2, error);
            } else {
                this.timeFile = timeFile;
                solver.setTimeFilePath(timeFile.getAbsolutePath());

                if (principle1.isSelected()) selectedPrinciples.add("Lawfullness");
                if (principle2.isSelected()) selectedPrinciples.add("Right-to-erasure");
                if (principle3.isSelected()) selectedPrinciples.add("Right-to-access");
                if (principle4.isSelected()) selectedPrinciples.add("Storage-limitation");
                if (selectedPrinciples.isEmpty())
                    selectedPrinciples.addAll(List.of("Lawfullness", "Right-to-erasure", "Right-to-access", "Storage-limitation"));

                ArrayList<String> selectedDatas = new ArrayList<>();
                ArrayList<String> selectedUsers = new ArrayList<>();
                ArrayList<String> selectedProcesses = new ArrayList<>();

                for (CheckBox d : datasBoxes) {
                    if (d.isSelected()) selectedDatas.add(d.getText());
                }
                for (CheckBox u : usersBoxes) {
                    if (u.isSelected()) selectedUsers.add(u.getText());
                }
                for (CheckBox p : processesBoxes) {
                    if (p.isSelected()) selectedProcesses.add(p.getText());
                }

                Converter converter = new Converter(selectedPrinciples, graphPath, selectedDatas, selectedUsers, selectedProcesses);
                solveController.setConverter(converter);

                solveController.setSolver(solver);
                try {
                    initResultsScreen();
                } catch (IOException err) {
                    throw new RuntimeException(err);
                }
                activate("resultsScreen");

            }
        });

        Button vizGraphButton = new Button(" Vizualize graph ");
        vizGraphButton.setOnAction(e -> {
            previousScreen = "choiceScreen";
            if (neo == null) {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "Selected provenance graph will be loaded to Neo4J. Please log in to continue. Selected graphDB will be deleted and replaced by " + graph.getName() + ". Continue ?", ButtonType.YES, ButtonType.NO, ButtonType.CANCEL);
                alert.showAndWait();

                if (alert.getResult() == ButtonType.YES) {
                    nextScreen = "graphVizScreen";
                    initNeo4jLogInScreen();
                    activate("neo4jLogInScreen");

                }
            } else {
                initGraphVizScreen("MATCH (n)-[r]->(m) RETURN *");
                activate("graphVizScreen");
            }
        });
//        Label precision = new Label("NOTE: Not specifying a particular data, user or process comes down to selecting everything in this category");
//        precision.setWrapText(true);


        Button returnBtn = new Button("Previous");
        returnBtn.setOnAction(e -> {
            initGraphPathScreen();

            activate("graphPathScreen");
        });

        scroll.setContent(choiceScreen);

        VBox choiceScreenScrollable = new VBox(10);
        choiceScreenScrollable.setPadding(new Insets(20, 20, 20, 20));

        choiceScreenScrollable.getChildren().addAll(choiceScreen, scroll, submitButton, vizGraphButton, returnBtn);

        screenMap.put("choiceScreen", choiceScreenScrollable);

    }

    /**
     * Initialises the Neo4J login screen, where the user is invited to put credentials to access the GraphDB.
     */
    public void initNeo4jLogInScreen() {
        VBox neo4jLogInScreen = new VBox(10);
        neo4jLogInScreen.setPadding(new Insets(20, 20, 20, 20));

        Label uri = new Label("Database URI");
        uri.setWrapText(true);
        Label user = new Label("User");
        user.setWrapText(true);
        Label password = new Label("Password");
        password.setWrapText(true);

        TextField uriField = new TextField();
        uriField.setPromptText("Database URI");
        TextField userField = new TextField();
        uriField.setPromptText("User");
        PasswordField passwordField = new PasswordField();
        passwordField.setPromptText("Password");

        Button returnButton = new Button("Previous");
        returnButton.setOnAction(e -> {
            activate(previousScreen);
        });

        Button submitButton = new Button(" Load ");
        submitButton.setOnAction(event -> {
            neo = new Neo4jInterface();
            neo.setParameters(uriField.getText(), userField.getText(), passwordField.getText());
            passwordField.clear();
            if (nextScreen.equals("graphVizScreen")) {
                System.out.println("Loading provenance graph from " + graph.getPath());
                neo.retrieveGraphDB(graph.getPath());
                initGraphVizScreen("MATCH (n)-[r]->(m) RETURN *");
            } else {
                neo.retrievePrologPG();
                File graph = new File(neo.generatedPrologGraphPath);
                if (graph.isFile()) {
                    this.graph = graph;
                    try {
                        initChoiceScreen();
                    } catch (IOException e) {
                        Text error = new Text("Parsed file opening error");
                        neo4jLogInScreen.getChildren().add(error);
                    }
                }
            }
            activate(nextScreen);
        });

        neo4jLogInScreen.getChildren().addAll(uri, uriField, user, userField, password, passwordField, submitButton, returnButton);
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
     * Initialises the results screen displaying the list of every detected issue. The screen also allows the user to choose to
     * display the provenance graph, by seeing a sub-graph for every issue.
     * @throws IOException In case of an issue returning to the choice screen (issue with the parser)
     */
    public void initResultsScreen() throws IOException {
        VBox resultsScreen = new VBox(10);
        resultsScreen.setPadding(new Insets(20, 20, 20, 20));
        Label label = new Label("Results :");
        Text results = new Text(solveController.solve());
        resultsScreen.getChildren().addAll(label, results);

        ScrollPane scroll = new ScrollPane();
        scroll.setContent(resultsScreen);

        VBox resultsScreenScrollable = new VBox(10);
        resultsScreenScrollable.setPadding(new Insets(20, 20, 20, 20));

        resultsScreenScrollable.getChildren().addAll(resultsScreen, scroll);

        Button visualizeGraph = new Button(" Visualize graph ");
        visualizeGraph.setOnAction(e -> {
            previousScreen = "resultsScreen";

            if (neo == null) {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "Selected provenance graph will be loaded to Neo4J. Please log in to continue. Selected graphDB will be deleted and replaced by " + graph.getName() + ". Continue ?", ButtonType.YES, ButtonType.NO, ButtonType.CANCEL);
                alert.showAndWait();

                if (alert.getResult() == ButtonType.YES) {
                    nextScreen = "graphVizScreen";
                    initNeo4jLogInScreen();
                    activate("neo4jLogInScreen");
                }

            } else {
                try {
                    initGraphVizScreen(solveController.getSolver().getIssues().get(0).toCypherQuery());
                    activate("graphVizScreen");
                } catch (IndexOutOfBoundsException ex){
                    System.out.println("No issues to display (case yet to implement)");
                }
            }
        });

        Button newVerif = new Button("New compliance checking");
        newVerif.setOnAction(e -> {
            try {
                initChoiceScreen();
                activate("choiceScreen");
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        });
        resultsScreenScrollable.getChildren().addAll(visualizeGraph, newVerif);


        screenMap.put("resultsScreen", resultsScreenScrollable);

    }

    /**
     * Initialises the graph visualisation screen. The display comes from an HTML page generated according to the visualisation needs :
     * the query tells which elements of the GraphDB should be displayed.
     * @param query CYPHER query stating the GraphDB elements to display
     */
    public void initGraphVizScreen(String query) {
        VBox graphVizScreen = new VBox(10);
        graphVizScreen.setPadding(new Insets(20, 20, 20, 20));
        HBox graphVizAndIssuesScreen = new HBox(10);

        WebView webView = new WebView();
        WebEngine webEngine = webView.getEngine();
        neo.buildVizHtmlFile(query);
        String url = Objects.requireNonNull(getResource("/index.html")).toExternalForm();

        if (previousScreen.equals("resultsScreen")) {
            ObservableList<Issue> issues = new ObservableListWrapper<>(solveController.getSolver().getIssues());
            final ListView<Issue> listView = new ListView<>();
            listView.setPrefSize(400, 450);

            listView.setItems(issues);
            listView.setCellFactory(ComboBoxListCell.forListView(issues));
            Button reloadButton = new Button(" Reload ");
            reloadButton.setOnAction(e -> {
                Issue issue = listView.getSelectionModel().getSelectedItem();
                String cypher = issue.toCypherQuery();
                System.out.println("[DEBUG] Cypher généré pour l'issue " + issue.getId() + " :\n" + cypher + "\n");
                neo.buildVizHtmlFile(cypher);
                System.out.println("[DEBUG] URL index.html = " + url);

                webEngine.reload();
            });
            VBox issuesScreen = new VBox(10);
            issuesScreen.getChildren().addAll(listView, reloadButton);
            graphVizAndIssuesScreen.getChildren().add(issuesScreen);
        }

        webEngine.load(url);

        Button returnButton = new Button(" Previous ");
        returnButton.setOnAction(e -> {
            activate(previousScreen);
        });
        graphVizAndIssuesScreen.getChildren().add(webView);
        graphVizScreen.getChildren().addAll(graphVizAndIssuesScreen, returnButton);
        screenMap.put("graphVizScreen", graphVizScreen);

    }

    /**
     * Displays a screen.
     * @param name Screen name (the one under which the screen was put to the screenMap)
     */
    public void activate(String name) {
        main.setRoot(screenMap.get(name));
    }

    public Pane getBasePane() {
        return screenMap.get("graphPathScreen");
    }
}
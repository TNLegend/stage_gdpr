package Traducteur;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class Parser {
    private final File prologFile;

    public Parser(File graphe) {
        this.prologFile = graphe;
    }

    // Méthode générique pour extraire le premier argument d'un prédicat
    private void extractFromPredicate(String predicateName, Set<String>resultSet) throws IOException {
        // Le regex cherche : nom_du_predicat('VALEUR_A_CAPTURER', ...
        String regex = "^" + predicateName + "\\('([^']*)'.*";
        Pattern pattern = Pattern.compile(regex);

        // try-with-resources pour fermer le fichier automatiquement
        try (BufferedReader br = new BufferedReader(new FileReader(prologFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.find()) {
                    resultSet.add(matcher.group(1)); // group(1) est la valeur capturée
                }
            }
        }
    }

    // Méthode générique pour extraire le deuxième argument
    private void extractSecondArgFromPredicate(String predicateName, Set<String> resultSet) throws IOException {
        String regex = "^" + predicateName + "\\('[^']*',\\s*'([^']*)'.*";
        Pattern pattern = Pattern.compile(regex);

        try (BufferedReader br = new BufferedReader(new FileReader(prologFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.find()) {
                    resultSet.add(matcher.group(1));
                }
            }
        }
    }

    public List<String> parserData() throws IOException {
        Set<String> personalDataSet = new HashSet<>();
        // Regex pour trouver wasGeneratedBy(..., 'personal data', ...)
        String regex = "^wasGeneratedBy\\('([^']*)',.*,'personal data'.*";
        Pattern pattern = Pattern.compile(regex);

        try (BufferedReader br = new BufferedReader(new FileReader(prologFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.find()) {
                    personalDataSet.add(matcher.group(1));
                }
            }
        }
        return personalDataSet.stream().collect(Collectors.toList());
    }

    public List<String> parserUser() throws IOException {
        Set<String> userSet = new HashSet<>();
        // On extrait le 2ème argument de wasControlledBy
        extractSecondArgFromPredicate("wasControlledBy", userSet);
        return userSet.stream().collect(Collectors.toList());
    }

    public List<String> parserProcess() throws IOException {
        Set<String> processSet = new HashSet<>();
        // On extrait le 1er argument de action
        extractFromPredicate("action", processSet);
        return processSet.stream().collect(Collectors.toList());
    }
}
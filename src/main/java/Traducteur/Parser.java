package Traducteur;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;


public class Parser {
    private File fichier;

    public Parser(File graphe) {
        this.fichier = graphe;
    }

    public List<String> parserData() throws IOException {
        List<String> list = new ArrayList<>();
        String[] dataArray;
        String data;
        FileReader fr = new FileReader(fichier);
        BufferedReader br = new BufferedReader(fr);
        String ligne = br.readLine();
        StringBuilder listBuilder = new StringBuilder();
        char caractere;
        StringBuilder dataBuilder = new StringBuilder();

        if(fichier.length()!= 0) {

            while (ligne != null) {
                if ((ligne.startsWith("wasGeneratedBy")) && ligne.contains("'personal data'")) {
                    int i = 16;
                    while (ligne.charAt(i) != '\'') {
                        caractere = ligne.charAt(i);
                        dataBuilder.append(caractere);
                        i++;
                    }
                    if (dataBuilder.isEmpty()) {
                        throw new NullPointerException();
                    }
                    listBuilder.append(dataBuilder).append(",");
                    dataBuilder.setLength(0);
                }

                //Pour boucler
                ligne = br.readLine();

            }
            data = listBuilder.toString();
            dataArray = data.split(",");
            list = Arrays.asList(dataArray);
            list = list.stream().distinct().collect(Collectors.toList());

            if(list.size() == 1 && list.get(0).isEmpty()) list.clear();

        }

        return list;
    }

    public List<String> parserUser() throws IOException {
        List<String> list = new ArrayList<>();
        String[] userArray;
        String user;
        FileReader fr = new FileReader(fichier);
        BufferedReader br = new BufferedReader(fr);
        String ligne = br.readLine();
        StringBuilder listBuilder = new StringBuilder();
        StringBuilder userBuilder = new StringBuilder();
        char caractere;

        if(fichier.length()!= 0) {

            while (ligne != null) {
                if (ligne.startsWith("wasControlledBy")) {
                    int i = 17;
                    while (ligne.charAt(i) != ',') {
                        i++;
                    }
                    //i += 2;
                    while (ligne.charAt(i) == ' ' || ligne.charAt(i) == ','){
                        i++;
                    }
                    i++;
                    while (ligne.charAt(i) != '\'') {
                        caractere = ligne.charAt(i);
                        userBuilder.append(caractere);
                        i++;

                    }

                    if (userBuilder.isEmpty()) {
                        throw new NullPointerException();
                    }

                    listBuilder.append(userBuilder).append(",");
                    userBuilder.setLength(0);
                }

                ligne = br.readLine();

            }
            user = listBuilder.toString();
            userArray = user.split(",");
            list = Arrays.asList(userArray);
            list = list.stream().distinct().collect(Collectors.toList());

            if(list.size() == 1 && list.get(0).isEmpty()) list.clear();

        }

        return list;
    }


    public List<String> parserProcess() throws IOException {
        List<String> list = new ArrayList<>();
        String[] processArray;
        String process;
        FileReader fr = new FileReader(fichier);
        BufferedReader br = new BufferedReader(fr);
        String ligne = br.readLine();
        StringBuilder listBuilder = new StringBuilder();
        char caractere;
        StringBuilder processBuilder = new StringBuilder();

        if(fichier.length()!= 0) {

            while (ligne != null) {
                if (ligne.startsWith("action")) {
                    int i = 8;
                    while (ligne.charAt(i) != '\'') {
                        caractere = ligne.charAt(i);
                        processBuilder.append(caractere);
                        i++;
                    }
                    if (processBuilder.isEmpty()) {
                        throw new NullPointerException();
                    }
                    listBuilder.append(processBuilder).append(",");
                    processBuilder.setLength(0);
                }

                //Pour boucler
                ligne = br.readLine();

            }
            process = listBuilder.toString();
            processArray = process.split(",");
            list = Arrays.asList(processArray);
            list = list.stream().distinct().collect(Collectors.toList());

            if(list.size() == 1 && list.get(0).isEmpty()) list.clear();

        }

        return list;
    }

}

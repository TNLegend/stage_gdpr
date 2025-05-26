package Solver;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Measurements {
    public static void main(String[] args) throws IOException {
        File results = new File("results.csv");
        BufferedWriter bw = new BufferedWriter(new FileWriter(results));
        StringBuilder sb = new StringBuilder();
        bw.write("FILE_NAME,TYPE,NB_USERS,SIZE (ko),SOLVING_TIME (ms)\n");
        bw.flush();

        Solver solver = new Solver();

        solver.setTimeFilePath("/home/pauline/IdeaProjects/rgpd-compliance/time_default_long.pl");
        solver.setQueries(List.of("legal(P, D, PU, T, DP, C).", "eraseCompliant(D, T, P).", "rightAccess(S, TE).", "storageLimitation(D, TU)."));
        File testFiles = new File("/home/pauline/IdeaProjects/Code_generateur_graphes/Output");
        File[] filesList = testFiles.listFiles();
        Arrays.sort(filesList, Collections.reverseOrder());
        for (final File fileEntry : filesList) {
            String name = fileEntry.getName();
            String[] params = StringUtils.substringBefore(name, ".").split("_");
            sb.append(name).append(",").append(params[2]).append(",").append(params[0]).append(",");
            long size = FileUtils.sizeOf(fileEntry) / (1000);
            sb.append(size).append(",");

            System.out.println("current file : " + name);
            try {
                System.out.println("measuring computing time...");
                long total = 0;
                int i;
                for (i = 0; i < 10; i++) {
                    solver.setProvenanceGraphPath(fileEntry.getPath());
                    final long t_start = System.nanoTime();
                    String sol = solver.solve();
                    long time = System.nanoTime() - t_start;
                    total += time / 1_000_000;
                    if (i!=0){
                        System.out.print("(current avg time = " + total/i +" ms)");
                    }
                    System.out.print(" progress : [");
                    for (int j = 0; j < i ; j++){
                        System.out.print("=");
                    }
                    for (int j = i; j < 10 ; j++){
                        System.out.print(" ");
                    }
                    System.out.print("]\r");
                    if ((time) * Math.pow(10,-9) > 60){
                        i++;
                        break;
                    }
                }
                total /= i;
                System.out.println();
                System.out.println("done. avg computing time = " + total + " ms.");

                sb.append(total).append("\n");
                System.out.println("SUMMARY FOR " + fileEntry.getName() + " : " + sb);
                bw.write(sb.toString());
                bw.flush();
                sb = new StringBuilder();
            } catch (IOException e) {
                System.out.println(e);
                System.out.println("error opening " + fileEntry.getName() + ". on to the next file...");
                sb = new StringBuilder();
            }
        }
        bw.close();
        System.out.println("done.");
    }
}

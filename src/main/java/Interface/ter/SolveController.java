package Interface.ter;

import Traducteur.Converter;
import Solver.SolverInterface; // CHANGEMENT : On importe l'interface
import java.io.IOException;
import java.util.List;

public class SolveController {
    // Le converter sera toujours utile pour transformer les choix de l'UI en une liste de principes
    private Converter converter;

    // CHANGEMENT : Le contrôleur ne connaît plus "Solver", mais seulement le contrat "SolverInterface"
    private SolverInterface solver;

    public void setConverter(Converter converter) {
        this.converter = converter;
    }

    // CHANGEMENT : Le setter accepte n'importe quel objet qui implémente SolverInterface
    public void setSolver(SolverInterface solver) {
        this.solver = solver;
    }

    // CHANGEMENT : Le getter retourne l'interface
    public SolverInterface getSolver() {
        return solver;
    }

    /**
     * Cette méthode est maintenant beaucoup plus simple. Elle délègue tout le travail
     * au solveur qui lui a été assigné (soit Prolog, soit Cypher).
     */
    public String solve() throws IOException {
        // On récupère les informations de base depuis le converter
        String graphPath = converter.getCheminGraphe();
        List<String> principles = converter.getPrincipes(); // Vous aurez besoin d'une méthode getPrincipes() dans Converter
        String timePath = "..."; // Ce chemin devra être récupéré depuis le ScreenController

        final long t_start = System.nanoTime();

        // On appelle la méthode "solve" de l'interface, sans se soucier de l'implémentation
        String sol = solver.solve(principles, graphPath, timePath);

        System.out.println("Solving time (" + solver.getClass().getSimpleName() + "): " + ((System.nanoTime() - t_start) / 1_000_000) + " ms.");
        return sol;
    }
}
package Interface.ter;

import Traducteur.Converter;
import Solver.Solver;
import java.io.IOException;

public class SolveController {
    private Converter converter;
    private Solver solver;

    public void setConverter(Converter converter) {
        this.converter = converter;
    }

    public void setSolver(Solver solver) {
        this.solver = solver;
    }

    public Solver getSolver() {
        return solver;
    }

    public String solve() throws IOException {
        solver.setQueries(converter.ConvertToPrologQuery());
        solver.setProvenanceGraphPath(converter.getCheminGraphe());

        final long t_start = System.nanoTime();
        String sol = solver.solve();
        System.out.println(((System.nanoTime() - t_start) / 1_000_000) + " ms solving time.");
        return sol;
    }
}

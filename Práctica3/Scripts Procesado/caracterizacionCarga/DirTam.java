import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.BufferedReader;

public class DirTam {
    public static void main (String [] args) {
        try {
            String lineaDir = null;
            String lineaTam = null;
            FileWriter file2 = new FileWriter("dirTam.data");
            PrintWriter printer = new PrintWriter(file2);
            FileReader file3 = new FileReader("todasDirecciones.data");
            FileReader file4 = new FileReader("todosTamaños.data");
            BufferedReader brDir = new BufferedReader(file3);
            BufferedReader brTam = new BufferedReader(file4);

            while ((lineaDir = brDir.readLine()) != null) {
                lineaTam = brTam.readLine();
                printer.println(lineaDir + " " +lineaTam);
            }

            file2.close();
            file3.close();
            file4.close();

        } catch (Exception e){
            e.printStackTrace();
        }
    }
}


import java.util.ArrayList;
import java.util.HashMap;
import java.math.BigInteger;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.BufferedReader;

public class NumAccesos {
    public static void main (String [] args) {
        HashMap<String, Integer> numAccesos = new HashMap<>();
        HashMap<String, BigInteger> tamMedios = new HashMap<>();
        HashMap<String, BigInteger> tiemposMedios = new HashMap<>();

        // procesado del número de accesos a cada fichero
        try {
            String lineDir = null;
            FileReader fileDirecciones = new FileReader("todasDirecciones.data");
            BufferedReader buffer = new BufferedReader(fileDirecciones);
            while ((lineDir = buffer.readLine()) != null) {
                if (numAccesos.get(lineDir) == null) {
                    numAccesos.put(lineDir, 0);
                } else {
                    numAccesos.replace(lineDir, numAccesos.get(lineDir)+1);
                }
            }
            fileDirecciones.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // procesado del tamaño medio de cada fichero
        try {
            String lineDirTam = null;
            FileReader fileDirTam = new FileReader("dirTam.data");
            BufferedReader brDirTam = new BufferedReader(fileDirTam);
            while((lineDirTam = brDirTam.readLine()) != null) {
                String[] dirTam = lineDirTam.split(" ");
                if (tamMedios.get(dirTam[0]) == null) {
                    if (dirTam[1].equals("-"))
                        tamMedios.put(dirTam[0], BigInteger.ZERO);
                    else
                        tamMedios.put(dirTam[0], new BigInteger(dirTam[1]));
                } else {
                    if (dirTam[1].equals("-"))
                        tamMedios.replace(dirTam[0], tamMedios.get(dirTam[0]).add(BigInteger.ZERO));
                    else
                        tamMedios.replace(dirTam[0], tamMedios.get(dirTam[0]).add(new BigInteger(dirTam[1])));
                }

            }
            // calculo del tamaño medio
            tamMedios.forEach((k,v) -> {
                if (numAccesos.get(k) != 0) {
                    tamMedios.replace(k, v.divide(new BigInteger(String.valueOf(numAccesos.get(k)))));
                }
            });
            fileDirTam.close();
        }catch (Exception e) {
            e.printStackTrace();
        }

        // procesado del tiempo de ejecución de cada archivo
        try {
            String lineDirTime = null;
            FileReader fileDirTime = new FileReader("dirTiem.data");
            BufferedReader brDirTime = new BufferedReader(fileDirTime);
            while((lineDirTime = brDirTime.readLine()) != null) {
                String[] dirTime = lineDirTime.split(" ");
                if (tiemposMedios.get(dirTime[0]) == null) {
                    if (dirTime[1].equals("-"))
                        tiemposMedios.put(dirTime[0], BigInteger.ZERO);
                    else
                        tiemposMedios.put(dirTime[0], new BigInteger(dirTime[1]));
                } else {
                    if (dirTime[1].equals("-"))
                        tiemposMedios.replace(dirTime[0], tiemposMedios.get(dirTime[0]).add(BigInteger.ZERO));
                    else
                        tiemposMedios.replace(dirTime[0], tiemposMedios.get(dirTime[0]).add(new BigInteger(dirTime[1])));
                }

            }
            // calculo del tiempo medio
            tiemposMedios.forEach((k,v) -> {
                if (numAccesos.get(k) != 0) {
                    tiemposMedios.replace(k, v.divide(new BigInteger(String.valueOf(numAccesos.get(k)))));
                }
            });
            fileDirTime.close();
        }catch (Exception e) {
            e.printStackTrace();
        }

        // escribimos los resultados en un fichero en formato CSV el formato del arrchivo de salida que luego exportaremos a Excel es el siguiente:
        // FicheroRequeridoAlServidor,NumeroAccesos,TamñoMedio,TiempoEjecucionMedio
        // claveDiccionario,valor1,valor2

        try {
            FileWriter ficheroSalida = new FileWriter("entradaStatGraphics.csv");
            PrintWriter csvPrinter = new PrintWriter(ficheroSalida);

            csvPrinter.println("FicheroPedidoAlServidorWeb<NumeroAccesos<TamañoMedioFichero<TiempoMedioFichero");
            tiemposMedios.forEach((k,v) -> {
                csvPrinter.println(k+"<"+numAccesos.get(k)+"<"+tamMedios.get(k)+"<"+tiemposMedios.get(k));
            });
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}

import java.util.Scanner;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

public class FicherosDif {
    public static void writeMapContent (HashMap<String, Integer> map) {
        // recorremos el mapa para ver que se han añadido correctamente
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            String key = entry.getKey();
            Integer value = entry.getValue();
            System.out.println(">>" + key + " - " + value);
        }
    }

    public static void writeArrayContent (ArrayList<String> array) {
        // recorremos el mapa para ver que se han añadido correctamente
        for (int i=0; i< array.size(); i++) {
            System.out.println("++" + array.get(i));
        }
    }

    public static void main (String [] args) {
        Scanner in = new Scanner(System.in);
        HashMap<String, Integer> contadorFicherosDiferentes = new HashMap<>();
        ArrayList<String> todosFicheros = new ArrayList<>();

        // leemos los datos de los ficheros diferentes y los metemos en el mapa con valor 1
        int i = 0;
        for (i=0; i<1236591; i++) {
            if (i<43327)
                contadorFicherosDiferentes.put(in.nextLine(), 1);
            if (i>=43327)
                todosFicheros.add(in.nextLine());

        }

        // mostramos el contenido para ver si es correcto
        // writeMapContent(contadorFicherosDiferentes);
        // mostramos el contenido para ver si es correcto
        // writeArrayContent(todosFicheros);

        for (i=0; i< todosFicheros.size();i++) {
            if (contadorFicherosDiferentes.containsKey(todosFicheros.get(i))) {
               contadorFicherosDiferentes.put(todosFicheros.get(i), contadorFicherosDiferentes.get(todosFicheros.get(i))+1); 
            }
        }
        int contador = 0;
        for (Map.Entry<String, Integer> entry : contadorFicherosDiferentes.entrySet()) {
            Integer value = entry.getValue();
            if (value == 1) 
                contador++;
        }
        System.out.println("Ficheros diferentes accedidos una sola vez: " + contador);
    }
}

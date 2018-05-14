import java.util.*;

public class Cluster {
    public static void writeMapContent(Hashmap<String, Integer> map) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            String key = entry.getKey();
            Integer value = entry.getValue();
            System.out.println(key + " - " + value);
        }
    }
    public static void main (String [] args) {
        Scanner in = new Scanner(System.in);
        HashMap<String, Integer> mapa = new HashMap<>();
        float[][] datos = new float[1125357][3];

        int contador = 0;
        while (in.hasNext()) {
            mapa.put(in.nextLine(), contador);
            contador++;
        }
        writeMapContent(mapa);
    }
}

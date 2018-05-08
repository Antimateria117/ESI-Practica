import java.util.ArrayList;
import java.lang.Math;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Locale;

public class dataRead {

  static ArrayList<ArrayList> data = new ArrayList<ArrayList>();
  static ArrayList<Float> tTotal = new ArrayList<Float>();
  static ArrayList<Float> fallos = new ArrayList<Float>();
  static ArrayList<Float> petPorSeg = new ArrayList<Float>();
  static ArrayList<Float> tPorPet = new ArrayList<Float>();


 public static void main(String[] args) {

/*
Args:
1: Filename
2: From test # (Included)
3: To test # (Included)
*/

  String filename;

//Loads the data
  for(int i = Integer.parseInt(args[1]); i <= Integer.parseInt(args[2]); i++)
  {
    filename = args[0] + i + ".osda";
    readFile(filename);
  }

/*
//Debug
  System.out.println(tTotal);
  System.out.println(fallos);
  System.out.println(petPorSeg);
  System.out.println(tPorPet);
*/

//Means
  float tTotalMean = getMean(tTotal);
  float fallosMean = getMean(fallos);
  float petPorSegMean = getMean(petPorSeg);
  float tPorPetMean = getMean(tPorPet);

//Standard Deviations
  float tTotalSD = getSD(tTotal, tTotalMean);
  float fallosSD = getSD(fallos, fallosMean);
  float petPorSegSD = getSD(petPorSeg, petPorSegMean);
  float tPorPetSD = getSD(tPorPet, tPorPetMean);

//Confidence Interval (Distance from mean)
  float tTotalCI = 2.7765f * (tTotalSD / (float) Math.sqrt(tTotal.size()));
  float fallosCI = 2.7765f * (fallosSD / (float) Math.sqrt(fallos.size()));
  float petPorSegCI = 2.7765f * (petPorSegSD / (float) Math.sqrt(petPorSeg.size()));
  float tPorPetCI = 2.7765f * (tPorPetSD / (float) Math.sqrt(tPorPet.size()));

//Removing the outer values
  for (int i = tTotal.size() - 1; i == 0; i--)
  {
    if (tTotal.get(i) < tTotalMean - tTotalCI || tTotal.get(i) > tTotalMean + tTotalCI)
    {
      tTotal.remove(i);
    }
  }
  for (int i = fallos.size() - 1; i == 0; i--)
  {
    if (fallos.get(i) < fallosMean - fallosCI || fallos.get(i) > fallosMean + fallosCI)
    {
      fallos.remove(i);
    }
  }
  for (int i = petPorSeg.size() - 1; i == 0; i--)
  {
    if (petPorSeg.get(i) < petPorSegMean - petPorSegCI || petPorSeg.get(i) > petPorSegMean + petPorSegCI)
    {
      petPorSeg.remove(i);
    }
  }
  for (int i = tPorPet.size() - 1; i == 0; i--)
  {
    if (tPorPet.get(i) < tPorPetMean - tPorPetCI || tPorPet.get(i) > tPorPetMean + tPorPetCI)
    {
      tPorPet.remove(i);
    }
  }

//Means after CI
  float tTotalMean2 = getMean(tTotal);
  float fallosMean2 = getMean(fallos);
  float petPorSegMean2 = getMean(petPorSeg);
  float tPorPetMean2 = getMean(tPorPet);

//Prints out the mean values after the CI
  System.out.printf(Locale.GERMANY, "%.3f\n", tTotalMean2);
  System.out.printf(Locale.GERMANY, "%.3f\n", fallosMean2);
  System.out.printf(Locale.GERMANY, "%.3f\n", petPorSegMean2);
  System.out.printf(Locale.GERMANY, "%.3f\n", tPorPetMean2);

/* NOT NEEDED
//Adding the data
  tTotal.add(tTotalMean);
  tTotal.add(tTotalMean2);
  fallos.add(fallosMean);
  fallos.add(fallosMean2);
  petPorSeg.add(petPorSegMean);
  petPorSeg.add(petPorSegMean2);
  tPorPet.add(tPorPetMean);
  tPorPet.add(tPorPetMean2);

//Debug
  System.out.println(tTotal);
  System.out.println(fallos);
  System.out.println(petPorSeg);
  System.out.println(tPorPet);
*/ 
}
//Returns the mean of a Float array
 public static float getMean (ArrayList<Float> array)
 {
  float mean = 0;
  for (int i = 0; i < array.size(); i++)
  {
    mean += array.get(i).floatValue();
  }
  mean = mean / array.size();
  return mean;
 }

//Returns the standard deviation of a Float array
 public static float getSD (ArrayList<Float> array, float mean)
 {
  float sum = 0;
  for (int i = 0; i < array.size(); i++)
  {
    sum += Math.pow(array.get(i).floatValue() - mean, 2);
  }
  sum = sum / array.size();
  sum = (float) Math.sqrt(sum);
  return sum;
 }


//Reads the file and loads the data in the class variables
 public static void readFile (String filename) {
  BufferedReader br = null;
  FileReader fr = null;

  try {
    fr = new FileReader(filename);
    br = new BufferedReader(fr);
    String sCurrentLine;

    if ((sCurrentLine = br.readLine()) != null) {
      tTotal.add(Float.valueOf(sCurrentLine));
    }
    if ((sCurrentLine = br.readLine()) != null) {
      fallos.add(Float.valueOf(sCurrentLine));
    }
    if ((sCurrentLine = br.readLine()) != null) {
      petPorSeg.add(Float.valueOf(sCurrentLine));
    }
    if ((sCurrentLine = br.readLine()) != null) {
      tPorPet.add(Float.valueOf(sCurrentLine));
    }

  } catch (IOException e) {
    e.printStackTrace();
  } finally {
    try {

      if (br != null)
      br.close();

      if (fr != null)
      fr.close();

    } catch (IOException ex) {
      ex.printStackTrace();
    }
  }
 }

}

// testing program for HangmanManager

import java.util.*;

public class HangmanTester {
   public static void main(String[] args) {
      
   System.out.println(keyMaker("Spongebob", 'o'));
   
   }
   
   public static String keyMaker(String s, char guess) {
      
      List<Integer> placesFound = new ArrayList<>();
      
      String pattern = "- - - - - - - - -";
      
      char[] patternChar = pattern.toCharArray();
      
      
      for (int i = 0; i < s.length(); i++) {
         if (s.charAt(i) == guess) {
            placesFound.add(i);
         }
      }
      
      for (int i = 0; i < placesFound.size(); i++) {
         patternChar[placesFound.get(i) * 2] = guess;
      }
      
      return new String(patternChar);
   }

}
// Ewan Lister
// CSE 143
// 05/21/2021
// TA: John Bato - Borja

// The AnagramSolver class allows a user to generate
// a list of anagrams constructed from the letters
// in a word or phrase that they submit. 


import java.util.*;
 
public class AnagramSolver {

   private List<String> dictionary;
   public AnagramSolver(List<String> list) {
   
      Map<String, LetterInventory> letterInventories = new HashMap<>();
      
      dictionary = new ArrayList(list);
      for (String s : list) {
         letterInventories.add(s, LetterInventory(s));   
      }
      
      
   }
   
   public void print(String s, int max) {
      LetterInventory phrase = new LetterInventory(s);
      List<String> anagrams = new ArrayList<>();
      
   }
   
   private void print(LetterInventory phrase, int max, List<String> anagrams) {
      if ((anagrams.size() <= max)) {
         if ((anagrams.size() == max || max == 0) && phrase.size() == 0) {
            println(anagrams.toString());
         } else {
            for (String s : dictionary) {
               LetterInventory possibleString = new LetterInventory(s);
               LetterInventory subtractedInventory = phrase.subtract(possibleString);
               if (subtractedInventory != null) {
                  anagrams.add(s);
                  print(subtractedInventory, max, anagrams);
                  anagrams.remove(anagrams.size() - 1);
               }
            }
         }
      } 
   }


}
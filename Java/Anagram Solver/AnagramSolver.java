// Ewan Lister
// CSE 143
// 05/23/2021
// TA: John Bato - Borja

// The AnagramSolver class allows a user to generate
// a list of anagrams constructed from the letters
// in a word or phrase that they submit.
// The anagrams are taken from a dictionary of
// acceptable terms or words provided by the user.
// The class includes methods for constructing an anagram
// solver, and printing a list of anagrams.

import java.util.*;
 
public class AnagramSolver {

   // Stores dictionary provided by user.
   private List<String> dictionary;
   
   // Stores a map between dictionary entries
   // and a more easily processed form of each entry.
   private Map<String, LetterInventory> letterInventories;
   
   // accepts a list of strings, and constructs
   // an AnagramSolver object.
   public AnagramSolver(List<String> list) {
      dictionary = list;
      letterInventories = new HashMap<>();
      for (String s : list) {
         LetterInventory stringInventory = new LetterInventory(s);
         letterInventories.put(s, stringInventory);   
      }
   }
   
   // pre: int max must not be less than 0, otherwise throws
   // an IllegalArgumentException.
   // post: generates a list of sets of anagrams that can
   // be constructed from the characters in String s. Int max determines
   // how many anagrams per set are generated.
   // Entering 0 for int max will generate all possible anagram sets
   // for a given String s. Anagram generation follows the order
   // of entries found in the user dictionary.
   public void print(String s, int max) {
      if (max < 0) {
         throw new IllegalArgumentException();
      }
      LetterInventory phrase = new LetterInventory(s);
      List<String> anagrams = new ArrayList<>();
      print(phrase, max, anagrams, pruneDictionary(phrase));
      
   }
   
   // this method facilitates printing the anagrams formed
   // from the word.
   private void print(LetterInventory phrase, int max, List<String> anagrams, 
                                                  List<String> usableWords) {
      if ((anagrams.size() <= max || max == 0)) {
         if (phrase.size() == 0) {
            System.out.println(anagrams.toString());
         } else {
            for (String s : usableWords) {
               LetterInventory subtractedInventory = subtractedInventory(phrase, 
                                                      letterInventories.get(s));
               if (subtractedInventory != null) {
                  anagrams.add(s);
                  print(subtractedInventory, max, anagrams, usableWords);
                  anagrams.remove(anagrams.size() - 1);
               }
            }
         }
      } 
   }
   
   // this method simplifies the printing process
   // by returning to the print() method only the
   // dictionary entries which can be made up of
   // characters taken from the user suggested phrase.
   private List<String> pruneDictionary(LetterInventory phrase) {
      List<String> usableWords = new ArrayList<>();
      for (String s : dictionary) {
         if (subtractedInventory(phrase, letterInventories.get(s)) != null) {
            usableWords.add(s);
         }   
      }
      return usableWords;
   }
   
   private LetterInventory subtractedInventory(LetterInventory minuend, 
                                               LetterInventory subtrahend) {
      return minuend.subtract(subtrahend);    
   } 
}
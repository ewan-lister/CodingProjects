// Ewan Lister
// 04/16/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// The HangmanManager class allows an administrator to 
// manage a game of cheating hangman, in which the 
// administrator/game-master does not initially pick a single
// word, and instead picks all words of the size that the player initially
// specifies, and as the user guesses letters, slowly picks smaller groups
// of words not containing that letter, until it is eventually cornered
// into picking a group of words containing a newly guessed letter.
// The class includes methods for constructing a manager, checking the group
// of words currently in use, checking which letters have already been
// guessed, checking how many guesses are left, checking the correctly guessed
// letters in the form of a typical hangman pattern e.g. "- o - e - s - -", 
// and recording that a letter has been guessed.

import java.util.*;

public class HangmanManager {
   
   // Words currently being considered by game-master.
   private Set<String> wordsAvailable;
   
   // Guesses left in game.
   private int guesses;
   
   // Stores the letters the player has guessed correctly
   // in the positions that they would appear in the
   // potential words remaining.
   private String pattern;
   
   private Set<Character> lettersGuessed;
   
   // pre: the word-length specified must not be less than 1, and the maximum
   // guesses allowed must not be less than 0 (otherwise throws an
   // IllegalArgumentException)
   // post: constructs a HangmanManager object, ititializes wordsAvailable
   // with all words of the given length that are in the dictionary,
   // and initializes guesses as the specified maximum.
   public HangmanManager(Collection<String> dictionary, int length, int max) {
      if (length < 1 || max < 0) {
         throw new IllegalArgumentException();
      }
      lettersGuessed = new TreeSet<>();
      wordsAvailable = new TreeSet<>();
      for (String s : dictionary) {
         if (s.length() == length) {
            wordsAvailable.add(s);
         }
      }
      guesses = max;
      pattern = dashPrinter(length);
   }
   
   // Returns the words which are currently being considered
   // by the game-master.
   public Set<String> words() {
      return wordsAvailable;
   }
   
   // returns the letters which have been guessed so far.
   public Set<Character> guesses() {
      return lettersGuessed;
   }
   
   // Returns how many guesses the player has left.
   public int guessesLeft() {
      return guesses;
   }
   
   // Returns the pattern string, representing the correctly
   // guessed letters in their respective positions, separated
   // by dashes representing blanks e.g "- o - d - n"
   public String pattern() {
      if (wordsAvailable.size() == 0) {
         throw new IllegalStateException();
      }
      return pattern;
   }

   // pre: number of guesses left must be at least 1, and
   // wordsAvailable must contain at least one word (otherwise throws
   // IllegalStateException), and the user must not guess a letter which
   // has already been guessed (otherwise throws IllegalArgumentException).
   // post: checking all possible patterns of the letter made by the words
   // currently under consideration, the method changes the pattern
   // to the one most commonly found in the words currently considered,
   // and changes wordsAvailable to include only the words with that pattern.
   // The method subtracts one from the player's guesses only if the letter
   // they guessed does not appear in the new pattern. 
   public int record(char guess) {
      if (guesses < 1 || wordsAvailable.size() == 0) {
         throw new IllegalStateException();
      }
      if (lettersGuessed.contains(guess)) {
         throw new IllegalArgumentException();
      }
      lettersGuessed.add(guess);
      Map<String, Set<String>> patternsToWords = new TreeMap<>();
      mapInitializer(patternsToWords, guess);
      String savedKey = wordSetComparer(patternsToWords);
      if (pattern.equals(savedKey)) {
         guesses--;
      }
      pattern = savedKey;
      wordsAvailable = new TreeSet<>(patternsToWords.get(savedKey));
      return characterCount(pattern, guess);
   }
   
   // Determines which set of words containing a given pattern
   // are the largest. Returns the contained pattern of the set
   // with the most words.
   private String wordSetComparer(Map<String, Set<String>> 
                                  patternsToWords) {
      int size = -1;
      String savedKey = "";
      for (String key : patternsToWords.keySet()) {
         if (patternsToWords.get(key).size() > size) {
            size = patternsToWords.get(key).size();
            savedKey = key;
         }
      }
      return savedKey;
      
   }
   
   // Initializes a map of character patterns to 
   // the words which contain said pattern.
   private void mapInitializer(Map<String, Set<String>> patternsToWords, 
                               char guess) {
      for (String s : wordsAvailable) {
         String comparedPattern = keyMaker(s, guess);    
         if (!patternsToWords.containsKey(comparedPattern)) {
            Set<String> wordsWithPattern = new TreeSet<>();
            patternsToWords.put(comparedPattern, wordsWithPattern);    
         }
         patternsToWords.get(comparedPattern).add(s);
      }
   }
   
   // Returns the amount of times a given character is
   // found in a given string.
   private int characterCount(String s, char letter) {
      int count = 0;
      for (int i = 0; i < s.length(); i++) {
         if (s.charAt(i) == letter) {
            count++;
         }
      }
      return count;
   }
   
   // Generates a pattern based on the preexisting pattern
   // found in all words being considered as well as 
   // how the guessed letter is contained in a given string.
   private String keyMaker(String s, char guess) {
      List<Integer> placesFound = new ArrayList<>();
      String patternCopy = "" ;
      char[] patternChar = patternCopy.toCharArray();
      for (int i = 0; i < pattern.length(); i++) {
         if (i % 2 == 0) {
            if (s.charAt(i / 2) == guess) {
            patternCopy += guess;
            } else {
            patternCopy += pattern.charAt(i);
            }
         } else {
            patternCopy += " ";
         }
      }
      return patternCopy;
   }
   
   
   // Returns a string representing the initial pattern
   // of the game, with the amount of dashes being equal
   // to the specified word length e.g "- - - - -" when
   // word length = 5.   
   private String dashPrinter(int length) {
      String originalPattern = "-";
      for (int i = 1; i < length; i++) {
         originalPattern += " -";
      }
      return originalPattern;
   }
   
}
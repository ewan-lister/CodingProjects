// Ewan LIster
// CSE 143
// 05/13/2021
// TA: John Bato - Borja

// The HangmanManager2 extends the HangmanManager class.
// This class makes a few small changes to the methods
// and gameplay typical of a HangmanManager object.
// These changes occur for the words(), guesses(), and
// record() methods. The words() and guesses() methods
// instead of returning an alterable reference to the
// set of words and letters guessed, now return an
// unmodifiable version. The record method has been
// modified such that if the player has one guess
// remaining, and then guesses, the manager tries to 
// win instantly by picking the first word that doesn't
// contain the letter and making that the
// only word on the list of words in consideration.

import java.util.*;

public class HangmanManager2 extends HangmanManager {
   
   public static final int NOT_FOUND_RETURN = 0;
   
   private Set<String> wordsAvailableComparison;
   private Set<Character> lettersGuessedComparison;
   
   private Set<String> unmodifiableWords;
   private Set<Character> unmodifiableLetters;
   
   public HangmanManager2(Collection<String> dictionary, int length, int max) {
      super(dictionary, length, max);
      
      wordsAvailableComparison = super.words();
      lettersGuessedComparison = super.guesses();
      unmodifiableWords = Collections.unmodifiableSet(super.words());
      unmodifiableLetters = Collections.unmodifiableSet(super.guesses());
   }
   
   // functions identically to super.words() method, except
   // that the String set returnes by the method is unmodifiable.
   public Set<String> words() {
      if (super.words() != wordsAvailableComparison) {
         wordsAvailableComparison = super.words();
         unmodifiableWords = Collections.unmodifiableSet(super.words());
      }
      return unmodifiableWords;
   }
   
   // functions identically to super.guesses() method, except
   // that the String set returnes by the method is unmodifiable.
   public Set<Character> guesses() {
      if (super.guesses() != lettersGuessedComparison) {
         lettersGuessedComparison = super.guesses();
         unmodifiableLetters = Collections.unmodifiableSet(super.guesses());
      }
      return unmodifiableLetters;
   }
   
   // functions identically to the super.record() method,
   // except: if guessesLeft() == 1, the manager
   // attempts to select the first word that doesn't
   // contain the letter in the set of words returned
   // by words(), and then restricts the set to
   // contain solely that word. If the manager
   // is able to find a word not containing the guess
   // then the manager would in affect win
   // automatically after that guess had been made.
   public int record(char guess) {
      if (guessesLeft() < 1 || words().size() == 0) {
         throw new IllegalStateException();
      }
      if (guesses().contains(guess)) {
         throw new IllegalArgumentException();
      }
      
      if (guessesLeft() == 1) {
         String wordWithoutGuess = "";
         String comparisonReference = wordWithoutGuess;
         boolean isFound = true;
         for (String s : words()) {
            if (s.contains("" + guess) && isFound) {
               wordWithoutGuess = s;
               isFound = false;
            }
         }
         if (comparisonReference != wordWithoutGuess) {
            super.words().clear();
            super.words().add(wordWithoutGuess);
            super.guesses().add(guess);
            return NOT_FOUND_RETURN;
         }
      }
      return super.record(guess);
   }
   
}
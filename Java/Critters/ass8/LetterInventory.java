// Ewan Lister
// 03/31/2021
// CSE143
// TA:   John Bato - Borja
//
// Letter Inventory constructs a letter inventory of a given string.

public class LetterInventory {

   public static final int ALPHABET_LENGTH = 26;
   private int[] inventory = new int[ALPHABET_LENGTH];
   private int size;
   
   
   public LetterInventory(String text) {
      initialInventory(text.toLowerCase());
   }
   
   public int getChar(char letter) {
      if ((letter - 'a') < ALPHABET_LENGTH && (letter - 'a') >= 0) {
         return inventory[letter - 'a'];
      } else {
         throw IllegalArgumentException;
      }
   } /*
   
   public void set(char letter, int value) {
   
   } */
   public int size() {
      return size;
   }
   
   public boolean isEmpty() {
      return size == 0;
   }
   
   public String toString() {
      String toString = "[";
      for (int i = 0; i < ALPHABET_LENGTH; i++) {
         for (int j = 0; j < inventory[i]; j++) {
            toString = toString + (char) ('a' + i);
         }
      }
      toString = toString + "]";
      return toString;
   } 
   
   /*
   public LetterInventory add(LetterInventory other) {
   
   }
   public LetterInventory subtract(LetterInventory other) {
   
   } */
   
   private void initialInventory(String userSample) {
      for (int i = 0; i < userSample.length(); i++) {
         if (userSample.charAt(i) - 'a' < ALPHABET_LENGTH && (userSample.charAt(i) - 'a') >= 0) {
            inventory[userSample.charAt(i) - 'a']++;
            size++;
         }
      }
   }
}

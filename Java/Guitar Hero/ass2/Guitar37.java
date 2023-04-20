// Ewan Lister
// 04/16/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// This class implements the Guitar interface in order to create
// a virtual guitar with 37 strings, ranging from the note A two octaves
// below standard A, up to an octave above standard A. The class
// contains methods for constructing a Guitar37, playing individual
// notes via keystrokes or specified values, checking the specific key
// mapping of the class, and obtaining samples and time values for the
// sound produced by the strings.

import java.util.*;
import java.lang.String;

public class Guitar37 implements Guitar {
   
   // Represents mapping of keyboard characters to notes, resembling typical
   // piano key layout. 'v' represents concert A in this specific class.
   public static final String KEYBOARD =
   "q2we4r5ty7u8i9op-[=zxdcfvgbnjmk,.;/' ";
   
   // Frequency in Hertz of pitch concert A.
   public static final double CONCERT_A = 440.0;
   
   // Number of notes per octave, can be tweaked for alternate tunings.
   public static final int CHROMATIC_SCALE = 12;
   
   private GuitarString[] strings;
   
   // Represents duration of time in calls of tic() which have passed
   // since first sample was taken.
   private int time;
   
   // Creates an array of 37 GuitarString objects, with the frequency
   // of these strings ranging from 110Hz to 880Hz, in logarithmically
   // spaced increments.
   public Guitar37() {
       strings = new GuitarString[37];
      for (int i = 0; i < 37; i++) {
         strings[i] = new
         GuitarString(CONCERT_A * Math.pow(2.0, 
         (double) (i - 24) / CHROMATIC_SCALE));
      }
   }
   
   // Plays note specified by integer pitch.
   // e.g. -24 plays A two octaves below concert A, 0 plays concert A.
   // Only plays values between -24 and 12 inclusively.
   public void playNote(int pitch) {
      if (pitch < 13 && pitch > -25) {
         strings[pitch + 24].pluck();
      }
   }
   
   // Returns true if specific keyboard character "string"
   // is included in the character mapping encoded by KEYBOARD,
   // and therefore usable for playing a string via keystroke.
   public boolean hasString(char string) {
      return KEYBOARD.contains("" + string);
   }
   
   // pre: char string must be contained within the String KEYBOARD,
   // (throws IllegalArgumentException otherwise).
   // post: plays the note specified by the specific character.
   // e.g. 'p' encodes middle C, or C4 on a piano.
   public void pluck(char string) {
      if (!hasString(string)) {
         throw new IllegalArgumentException();
      }
      strings[KEYBOARD.indexOf(string)].pluck();
   }
   
   // Returns the sum of the amplitude values stored by
   // each string.
   public double sample() {
      double sum = 0.0;
      for (int i = 0; i < 37; i++) {
         sum += strings[i].sample();
      }
      return sum;
   }
   
   // Moves to the next amplitude sample stored by each string,
   // simulating the effect of time on a sound wave.
   // Increments time by 1. 
   public void tic() {
      for (int i = 0; i < 37; i++) {
         strings[i].tic();
      }
      time++;
   }
   
   // Returns the amount of time that has passed since the first
   // call on tic(), measured in calls of tic().
   public int time() {
      return time;
   }
}

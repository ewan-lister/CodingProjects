// Ewan Lister
// 03/31/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
//

import java.util.*;
import java.lang.String;

public class Guitar37 implements Guitar {
   public static final String KEYBOARD =
   "q2we4r5ty7u8i9op-[=zxdcfvgbnjmk,.;/' ";  // keyboard layout
   
   public static final double CONCERT_A = 440.0;
   
   public static final int CHROMATIC_SCALE = 12;
   
   private GuitarString[] strings = new GuitarString[37];
   
   private int time;
   
   // create two guitar strings, for concert A and C
   public Guitar37() {
      for (int i = 0; i < 37; i++) {
         strings[i] = new
         GuitarString(CONCERT_A * Math.pow(2.0, (double) (i - 24) / CHROMATIC_SCALE));
      }
   }
   
   public void playNote(int pitch) {
      if (pitch <= 11 && pitch >= -24) {
         strings[pitch + 24].pluck();
      }
   }
   
   public boolean hasString(char string) {
      return KEYBOARD.contains("" + string);
   }
   
   public void pluck(char string) {
      if (hasString(string)) {
         strings[KEYBOARD.indexOf(string)].pluck();
      } else {
         throw new IllegalArgumentException();
      }
   }
   
   public double sample() {
      int sum = 0;
      for (int i = 0; i < 37; i++) {
         sum += strings[i].sample();
      }
      return sum;
   }
   
   public void tic() {
      for (int i = 0; i < 37; i++) {
         strings[i].tic();
      }
      time++;
   }
   
   public int time() {
      return time;
   }
}

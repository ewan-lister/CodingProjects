// Ewan Lister
// 03/31/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// 

import java.math.*;
import java.util.*;

public class GuitarString {
   
   public static final double ENERGY_DECAY_FACTOR = 0.996;
   private Queue<Double> ringBuffer;
   
   public GuitarString(double frequency) {
      if (frequency >= 0 || Math.round((44100 / frequency)) < 2) {
         throw new IllegalArgumentException();
      } else {
         ringBuffer = new LinkedList<Double>();
         for (int i = 0; i < Math.round((44100 / frequency)); i++) {
            ringBuffer.add(0.0);
         }
      }
   }
   
   public GuitarString(double[] init) {
      if (init.length < 2) {
         throw new IllegalArgumentException();
      } else {
         for (int i = 0; i < init.length; i++) {
            ringBuffer.add(init[i]);
         }
      }
   }
   
   public void pluck() {
      Random r = new Random();
      int initialSize = ringBuffer.size();
      for (int i = 0; i < initialSize; i++) {
         ringBuffer.remove();
         ringBuffer.add(r.nextDouble() - .5);
      }
   }
   
   public void tic() {
      
      double first = ringBuffer.remove();
      double second = ringBuffer.peek();
      
      ringBuffer.add(((first + second) / 2) * ENERGY_DECAY_FACTOR);
   
   }
   
   public double sample() {
      return ringBuffer.peek();
   }
}
// Ewan Lister
// 04/16/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// This class creates a virtual guitar string of any frequency above 0
// and below 22050 Hz. It includes methods for constructing the string
// via a frequency parameter, testing the string, plucking the string,
// simulating decay, and taking the most recent sample of the string amplitude.

import java.math.*;
import java.util.*;

public class GuitarString {

   // The rate by which the average amplitude of the sample decreases
   // per call of tic().
   public static final double ENERGY_DECAY_FACTOR = 0.996;
   
   // In current implementation, stores sampled sound as discrete
   // amplitude values.
   private Queue<Double> ringBuffer;
   
   // pre: SAMPLE_RATE divided by frequency, when rounded to the nearest
   // integer, must not be less than 2 or less than or equal to 0.
   // (throws IllegalArgumentException otherwise)
   // post: constructs an empty ringbuffer of size 
   // N = SAMPLE_RATE / frequency, rounded to the nearest integer.
   public GuitarString(double frequency) {
      int sampledFreq = (int) Math.round(StdAudio.SAMPLE_RATE / frequency);
      if (frequency <= 0 || sampledFreq < 2) {
         throw new IllegalArgumentException();
      }
      ringBuffer = new LinkedList<Double>();
      for (int i = 0; i < sampledFreq; i++) {
         ringBuffer.add(0.0);
      }
   }
   
   // Method is solely for testing purposes.
   // pre: init, an array representing a preloaded sample of amplitude values,
   // must not have a size less than 2 (throws IllegalArgumentException
   // otherwise).
   // post: initializes values stored in init to ringBuffer.
   public GuitarString(double[] init) {
      if (init.length < 2) {
         throw new IllegalArgumentException();
      }
      for (int i = 0; i < init.length; i++) {
         ringBuffer.add(init[i]);
      }
   }
   
   // Replaces each value in ringBuffer with a random double
   // between -.5 inclusively and .5 exclusively.
   // The random doubles represent the varying amplitudes
   // generated as a string vibrates
   public void pluck() {
      Random r = new Random();
      int initialSize = ringBuffer.size();
      for (int i = 0; i < initialSize; i++) {
         ringBuffer.remove();
         ringBuffer.add(r.nextDouble() - .5);
      }
   }
   
   // Cycles through ringBuffer and simulates a decay
   // in amplitude using the Karplus-Strong algorithm.
   public void tic() {
      double first = ringBuffer.remove();
      double second = ringBuffer.peek();
      ringBuffer.add(((first + second) / 2) * ENERGY_DECAY_FACTOR);
   }
   
   // Returns most recent amplitude value stored in ringBuffer.
   public double sample() {
      return ringBuffer.peek();
   }
}
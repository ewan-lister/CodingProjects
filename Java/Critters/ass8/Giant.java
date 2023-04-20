// Ewan Lister
// 03/12/2021
// CSE142
// TA:   Michelle Jose Morris
//
// Giant provides an object class for use in the Critter simulation.
// See getMove() method for object movement behavior. 

import java.awt.*;
import java.util.*;

public class Giant extends Critter {

   private Color color = Color.GRAY;
   
   private String[] s = {"fee", "fie", "foe", "fum"};
   
   private int moveCounter;
   
   // Giants are always the color gray.
   public Color getColor() {
      return Color.GRAY;
   }
   
   // Method returns specific movement of critter every turn.
   // Giants try to infect if there is a different critter in front,
   // hop if their are no obstructions, and turn right otherwise.
   public Action getMove(CritterInfo info) {
   
   moveCounter++;

      if (info.getFront() == Neighbor.OTHER) {
         return Action.INFECT;
      } else if (info.getFront() == Neighbor.WALL || info.getFront() == Neighbor.SAME) {
         return Action.RIGHT;
      } else {
         return Action.HOP;
      }

   }
   
   // Returns displayed string of critter.
   // Every 6 moves, displayed string changes from "fee" to "fie" to "foe"
   // to "fum". The cycle repeats indefinitely beginning with fee again.
   public String toString() {
      int value = moveCounter % 24;
      if (value < 6) {
         return s[0];
      } else if (value < 11) {
         return s[1];
      } else if (value < 23) {
         return s[2];
      } else {
         return s[3];
      }
   }
}
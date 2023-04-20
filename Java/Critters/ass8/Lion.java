// Ewan Lister
// 03/12/2021
// CSE142
// TA:   Michelle Jose Morris
//
// Lion provides an object class for use in the Critter simulation.
// See getMove() method for object movement behavior.

import java.awt.*;
import java.util.*;

public class Lion extends Critter {
   
   private String s = "L";
   
   private Color color; 
   
   private int moveCounter;
   
   private Color[] colors = {Color.RED, Color.GREEN, Color.BLUE};
   
   // Constructor creates lion object with initial color either red, green,
   // or blue color.
   public Lion () {
      color = getColor();
   }
   
   // Method returns specific movement of critter every turn.
   // Lion trys to infect if there is a different critter in front.
   // Turns until it points in the opposite direction if it hits a wall.
   // Turns to the right if there is a neighbor in front.
   // If no obstructions, lion critter hops.
   public Action getMove(CritterInfo info) {
      moveCounter++;
      
      if (info.getFront() == Neighbor.OTHER) {
         return Action.INFECT;
      } else if (info.getFront() == Neighbor.WALL || info.getRight() == Neighbor.WALL) {
         return Action.LEFT;
      } else if (info.getFront() == Neighbor.SAME) {
         return Action.RIGHT;
      } else {
         return Action.HOP;
      }  
   }
   
   // Method returns color of lion object.
   // Every three moves a lion critter randomly changes color to
   // either blue, green or red.
   public Color getColor() {
      if (moveCounter % 3 == 0) {
         double rand = Math.random();
         int value = (int) Math.floor(3 * rand);
         color = colors[value];
      }
      return color;
   }
   
   // Method returns displayed string of critter "L".
   public String toString() {
      return s;
   }
}
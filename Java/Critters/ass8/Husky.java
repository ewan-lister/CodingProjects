// Ewan Lister
// 03/12/2021
// CSE142
// TA:   Michelle Jose Morris
// 
// Husky provides an object class for use in the Critter simulation.
// See getMove() method for object movement behavior.

import java.awt.*;
import java.util.*;

public class Husky extends Critter {

   private String[] s = {"HU", "US", "SK", "KY", "Y ", " H"};
   
   private Color color = new Color(51, 0, 111);

   private boolean foundFriends;
   
   private int moveCounter;
   
   
   // Method returns specific movement of critter every turn.
   public Action getMove(CritterInfo info) {
      
      Neighbor same = Neighbor.SAME;
      
      Neighbor wall = Neighbor.WALL;
      moveCounter++;
      
      // Huskey only hops across the board until it encounters another husky or a wall,
      // then it stays put. 
      if (info.getFront() == same || info.getBack() == same || info.getRight() == same  
                             ||   info.getLeft() == same || info.getFront() == wall) {
         foundFriends = true;
      }
      
      // Huskey infects if it detects another critter. 
      // Turns to the right if there is a wall on its left side 
      // or if there is a husky infront and in back. Turns to the left if there
      // is a wall to its right. 
      if (foundFriends) {
         if (info.getFront() == Neighbor.OTHER) {
            return Action.INFECT;
         } else if ((((info.getFront() == same && info.getBack() == same) 
               &&  info.getLeft() == wall)) || info.getFront() == wall) {
            return Action.RIGHT;
         } else if (info.getRight() == wall) {
            return Action.LEFT;
         }
      }
      
      return Action.HOP;
   }
   
   // Method returns color of critter.
   // Displayed color is the RGB value for UW's
   // official purple color.
   public Color getColor() {
      return color;
   }
   
   // Method returns displayed string of critter.
   // Alternates each move by two characters through the string
   // "HUSKY ".
   public String toString() {

      return s[moveCounter % 6];
   } 
}
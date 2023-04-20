// Ewan Lister
// 03/12/2021
// CSE142
// TA:   Michelle Jose Morris
//
// Bear provides an object class for use in the Critter simulation.
// See getMove() method for object movement behavior.

import java.awt.*;

public class Bear extends Critter {

   private Color color;
   
   boolean binaryMove = true;
   
   // Constructor determines final color of bear,
   // picking between black or white.
   public Bear (Boolean Polar) {
      if (Polar) {
         color = Color.WHITE;
      } else {
         color = Color.BLACK;
      }
   }
   
   // Method returns specific movement of critter every turn.
   // Bear critter will attempt to infect if there is a different critter
   // in front, will hop if there is nothing infront, or will turn left
   // if there is a wall or a critter of the same type.
   public Action getMove(CritterInfo info) {
      binaryMove = !binaryMove;
      Neighbor inFront = info.getFront();
      
      if (inFront == Neighbor.OTHER) {
         return Action.INFECT;
      } else if (inFront == Neighbor.EMPTY) {
         return Action.HOP;
      } else {
         return Action.LEFT;
      }
      
   }
   
   // Method returns critter color. Either black or white.
   public Color getColor() {
      return color;
   }
   
   // Method returns displayed string of critter.
   // Bear string alternates between a backslack and forward slash.
   public String toString() {
      if (binaryMove){
         return "/";
      } else {
         return "\\";
      }
   }
   
}
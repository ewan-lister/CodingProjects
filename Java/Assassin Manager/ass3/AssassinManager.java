// Ewan Lister
// 04/16/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// The AssassinManager class allows a client to manage a game of assassin.
// Specifically, the class allows a game administrator to keep track
// of who is stalking whom and who has been killed by whom. The class includes
// methods for constructing a manager, printing the current kill ring,
// printing the current graveyard, recording an assassination, checking
// if individual is included in either the kill ring or graveyard, checking
// if the game is over, and checking the name of the winner.

import java.util.*;

public class AssassinManager {
   
   private AssassinNode frontKillRing;
   
   private AssassinNode frontGraveyard;
   
   // pre: parameter names must be a list with non-zero size
   // post: constructs a manager for a given game of assassin
   // where the stalking order is the same as the sequential
   // order of the list names.
   public AssassinManager(List<String> names) {
      if (names.size() == 0) {
         throw new IllegalArgumentException();
      }
      
      frontKillRing = new AssassinNode(names.get(0));
      
      AssassinNode current = frontKillRing;
      
      for (int i = 1; i < names.size(); i++) {
         current.next = new AssassinNode(names.get(i));
         current = current.next;
      }
   }
   
   // Prints the members of the game who are still alive,
   // and who is stalking whom.
   public void printKillRing() {
      AssassinNode current = frontKillRing;
      while (current.next != null) {
         System.out.println(current.name + " is stalking " + current.next.name);
         current = current.next;
      }
      System.out.println(current.name + " is stalking " + frontKillRing.name);
   }
   
   // Prints the members of the game who have already been killed,
   // and who killed them.
   public void printGraveyard() {
      if (frontGraveyard != null) {
         AssassinNode current = frontGraveyard;
         while (current != null) {
            System.out.println(current.name + " was killed by " + current.killer);
            current = current.next;
         }
      }
   }
   
   // Checks if a given player is in the kill ring,
   // returns true if a player is found.
   public boolean killRingContains(String name) {
      return contains(name, frontKillRing);
   }
   
   // Checks if a given player is in the graveyard,
   // returns true if a player is found.
   public boolean graveyardContains(String name) {
      return contains(name, frontGraveyard);
   }
   
   // Checks if the game is over i.e. if there is only
   // one player left in the kill ring.
   // Returns true if game is over.
   public boolean gameOver() {
      return frontKillRing.next == null;
   }
   
   // Returns the name of the winner of the game.
   public String winner() {
      if (gameOver()) {
         return frontKillRing.name;
      } else {
         return null;
      }
   }
   
   // pre: string name must be the name of one of the players
   // currently in the kill ring (throws IllegalArgumentException
   // otherwise). Game must not be over, or gameOver() must not return
   // true when kill() is called (throws IllegalStateException otherwise).
   // post: records the assassination of the player represented by the 
   // given name and sends the player to the graveyard.
   public void kill(String name) {
      if (!killRingContains(name)) {
         throw new IllegalArgumentException();
      }
      if (gameOver()) {
         throw new IllegalStateException();
      }
      
      AssassinNode oneBefore = oneBeforeFinder(name);
      
      AssassinNode oneAfter;
      
      AssassinNode victim;
      
      if (oneBefore.next == null) {
         oneAfter = frontKillRing.next;
         victim = frontKillRing;
         victim.next = frontGraveyard;
         frontGraveyard = victim;
         frontKillRing = oneAfter;
      } else {
         victim = oneBefore.next;
         oneAfter = oneBefore.next.next;
         victim.next = frontGraveyard;
         frontGraveyard = victim;
         oneBefore.next = oneAfter;
      }
      
      frontGraveyard.killer = oneBefore.name;
   }
   
   
   // Finds the player who is stalking the player with the given name.
   private AssassinNode oneBeforeFinder(String name) {
      AssassinNode current = frontKillRing;
      if (frontKillRing.name.toLowerCase().equals(name.toLowerCase())) {
         while (current.next != null) {
            current = current.next;
         }
         return current;  
      } else {
         while (current.next != null) {
            if (current.next.name.toLowerCase().equals(name.toLowerCase())) {
               return current;
            }
            current = current.next;
         }  
      }
      return null;
   }
   
   // Checks if a given player is contained within the given group of
   // players either graveyard or killring in this implementation.
   private boolean contains(String name, AssassinNode front) {
      AssassinNode current = front;
      while (current != null) {
         if ((current.name.toLowerCase()).equals(name.toLowerCase())) {
            return true;
         }
         current = current.next;
      }
      return false;
   }
}
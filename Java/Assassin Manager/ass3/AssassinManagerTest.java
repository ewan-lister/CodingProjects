
// AssassinManager class testing program.

import java.util.*;

public class AMTester {

   public static void main(String[] args) {
      
      List<String> names;
      
      listMaker(names);
      
      Scanner s = new Scanner(System.in());
      
      AssassinManager theBoys = new AssassinManager(names);
      
      
      
      
   
   }
   
   public void intro() {
      System.out.println("Welcome to the game of Assassin.");
   }
   
   public void listMaker(List<String> names, Scanner s) {
      System.out.println("Who would you like to play?");
      String input = " ";
      while (!input.equals("")) {
         input = s.nextLine();
         names.add(input);
      }
   }
   
   public void gamePlay(Scanner s) {
      System.out.println("Starting game now...");
      String input = "";
      while (!gameOver()) {
         System.out.println("Current kill ring: ");
         printKillRing();
         System.out.println("Current graveyard: ");
         printGraveyard();
         System.out.print("Who was killed this round? ");
         input = s.nextLine();
         System.out.println();
         kill(imput);
      }
      
      System.out.println("Wow! What a crazy game that was. Looks like " + winner() + " won!");
   } 
}
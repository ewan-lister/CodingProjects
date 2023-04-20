
// AssassinManager class testing program.

import java.util.*;

public class AMTester {

   public static void main(String[] args) {
      
      List<String> names = new ArrayList<>();
      
      Scanner s = new Scanner(System.in);
      
      intro();
      
      listMaker(names, s);
      
      AssassinManager theBoys = new AssassinManager(names);
      
      gamePlay(theBoys, s);
      
      
   
   }
   
   public static void intro() {
      System.out.println("Welcome to the game of Assassin.");
   }
   
   public static void listMaker(List<String> names, Scanner s) {
      System.out.print("Who would you like to play?");
      String input = " ";
      while (!input.equals("")) {
         input = s.nextLine();
         names.add(input);
         System.out.print("Next Player: ");
         System.out.println();
         
      }
   }
   
   public static void gamePlay(AssassinManager names, Scanner s) {
      System.out.println("Starting game now...");
      String input = "";
      while (!names.gameOver()) {
         System.out.println("Current kill ring: ");
         names.printKillRing();
         System.out.println("Current graveyard: ");
         names.printGraveyard();
         System.out.print("Who was killed this round? ");
         input = s.nextLine();
         System.out.println();
         names.kill(input);
      }
      
      System.out.println("Wow! What a crazy game that was. Looks like " + names.winner() + " won!");
   } 
}
// Ewan Lister
// 05/07/2021
// Section BB
// CSE143
// TA:   John Bato - Borja
//
// The GrammerSolver class allows a user to take a specific grammar
// and identify the non-terminals of that grammar, as well as generate
// entire terminal phrases based on the non-terminals of the grammar.
// The class includes methods for constructing a GrammarSolver, checking
// if the grammar contains a given non-terminal, returning a list of
// non-terminals in the grammar, and randomly generating a terminal 
// representation of a given non-terminal.
// 

import java.util.*;

public class GrammarSolver {

   private Map<String, List<String>> nonTerminalsToRules;
   
   public static final int NONTERMINAL_INDEX = 0;
   
   // pre: "grammar" passed in must be at least of size 1, and
   // not contain two or more entries for the same non-terminal
   // (otherwise throws IllegalArgumentException).
   // post: constructs a grammarSolver object. 
   public GrammarSolver(List<String> grammar) {
      if (grammar.size() == 0) {
         throw new IllegalArgumentException();
      }
      mapMaker(grammar);
      if (nonTerminalsToRules.keySet().size() != grammar.size()) {
         throw new IllegalArgumentException();
      }
   }
   
   // checks if the given string is contained as a non-terminal
   // in the grammar passed into the grammarSolver object.
   public boolean grammarContains(String symbol) {
      return nonTerminalsToRules.containsKey(symbol);
   }
   
   // pre: "symbol" must be contained as a non-terminal in grammar
   // (method is case sensitive)
   // post: generates an array of random terminal expressions 
   // representing the given non-terminal "symbol". 
   // e.g generate("<s>") might return "bob sat"
   public String[] generate(String symbol, int times) {
      if (!grammarContains(symbol)) {
         throw new IllegalArgumentException();
      }
      String[] phrases = new String[times];
      Random r = new Random();
      for (int i = 0; i < times; i++) {
         phrases[i] = generate(symbol, r);
      }
      return phrases;
   }
   
   // returns a string containing all non-terminals
   // found in the given grammar, enclosed by brackets
   // and separated by commas.
   public String getSymbols() {
      return nonTerminalsToRules.keySet().toString();
   }
   
   // interprets grammar in order to construct expressions
   // representing the given non-terminal "symbol".
   private String generate(String symbol, Random r) {
      String aggregatedString = "";
      if (grammarContains(symbol)) {
         List<String> rules = nonTerminalsToRules.get(symbol);
         int choice = r.nextInt(rules.size());
         String[] rulesArray = rules.get(choice).split("[ \t]+");
         for (String rule : rulesArray) {
            aggregatedString += generate(rule, r);
         }
         return aggregatedString;
      } else {
         return symbol + " ";   
      }
   }
   
   // separates the grammar into non-terminals, rules, and terminals
   // in order to make it more easily used for generating expressions.
   private void mapMaker(List<String> grammar) {
      nonTerminalsToRules = new TreeMap<>();
      for (String line : grammar) {
         String[] terminalAndRule = line.split("::=");
         List<String> rules = new ArrayList<>();
         String[] rulesArray = terminalAndRule[NONTERMINAL_INDEX + 1].split("[|]");
         for (String rule : rulesArray) {
            rules.add(rule.trim());
         } 
         nonTerminalsToRules.put(terminalAndRule[NONTERMINAL_INDEX].trim(), rules);
      }
   }
   
   
}
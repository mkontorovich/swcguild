/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package projectblackjack;

import java.util.Random;
import java.util.Scanner;


/**
 *
 * @author apprentice
 */
public class ProjectBlackjack {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);
        Random r = new Random();
        
        int playertotal;
        int playercard1;
        int playercard2;
        int playercard3;
        int dealertotal;
        int dealercard1;
        int dealercard2;
        int dealercard3;
        
        String playerhit="";
        
        System.out.println("Project Blackjack!");
        
        playertotal = 0;
        playercard1 = 2 + r.nextInt(10);
        playercard2 = 2 + r.nextInt(10);
        dealercard1 = 2 + r.nextInt(10);
        dealercard2 = 2 + r.nextInt(10);
        dealertotal = 0;        
        
        playertotal = playercard1 + playercard2;
        System.out.println("You drew " + playercard1 + " and " + playercard2 + ".");
        System.out.println("Your total is " + playertotal + ".\n");
        
        
        
        System.out.println("The dealer has " + dealercard1 + ".");
 //     System.out.println("Dealer's total is " + (dealercard1 + dealercard2));
        
        dealertotal = dealercard1 + dealercard2;
        
//        System.out.print("\nWould you like to \"hit\" or \"stay\"? ");
//        playerhit = sc.nextLine();
             
        while ((playertotal <= 21)) {
            
            System.out.print("\nWould you like to \"hit\" or \"stay\"? ");
            playerhit = sc.nextLine();
            
                if (playerhit.equals("stay")) {
                    break;
                }
            
            playercard3 = 2 + r.nextInt(10);
            System.out.print("You drew a(n) " + playercard3 + ".\n");
            playertotal = playertotal + playercard3;
            System.out.print("Your total is " + playertotal + ".");
                if (playertotal == 21) {
                    break;
                }
                if (playertotal > 21) {
                    System.out.println("\nYou bust.");
                    break;
                }
            
            
        }
        
        System.out.println("\nThe dealer shows " + dealertotal + ".");
        //player stays, dealer will decide based on if their dealertotal is 
        //less than 17 or not. if it's less, they hit, if it's more, they stay.
        
           while (dealertotal < 17) {
               
               dealercard3 = 2 + r.nextInt(10);
               dealertotal = dealertotal + dealercard3;
               System.out.println("Dealer chooses to hit.");
               System.out.println("Dealer drew a(n) " + dealercard3 + ".");
               System.out.println("Dealer total is " + dealertotal + ".");
               
                    if (dealertotal > 21) {
                    System.out.println("\nDealer busts.");
                    break;
                }
           }
           
              if (playertotal > 21) {
                  System.out.println("You lose.");
              } else if (dealertotal > 21) {
                  System.out.println("YOU WIN!");
              } else if (playertotal > dealertotal) {
                  System.out.println("YOU WIN!");
              } else {
                  System.out.println("You lose.");
              }

    }
}
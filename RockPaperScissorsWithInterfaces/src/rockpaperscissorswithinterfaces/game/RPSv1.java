/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.game;

import java.util.Random;
import rockpaperscissorswithinterfaces.data.RPSGameInfov1;

/**
 *
 * @author apprentice
 */
public class RPSv1 {
    
    //this class plays one round of rock paper scissors
    
    public RPSGameInfov1 play(int userChoice) {
        Random rGen = new Random();
        int computerChoice = rGen.nextInt(3) + 1;
        int result = checkWinner(userChoice, computerChoice);
        RPSGameInfov1 res = new RPSGameInfov1();
        res.setResult(result);
        res.setComputerChoice(computerChoice);
        res.setUserChoice(userChoice);
        return res;
    }
    
    // Rock = 1, Paper = 2, Scissors = 3
    // Tie = 0, User Wins = 1, Computer Wins = 2
    private int checkWinner(int userChoice, int computerChoice) {
        int result = 0;
        // tie
        if (userChoice == computerChoice) {
            result = 0;
        } else if (userChoice == 1 && computerChoice == 2) {
            // paper covers rock, computer wins
            result = 2;
        } else if (userChoice == 1 && computerChoice == 3) {
            // rock smashes scissors, user wins
            result = 1;
        } else if (userChoice == 2 && computerChoice == 1) {
            // paper covers rock, user wins
            result = 1;
        } else if (userChoice == 2 && computerChoice == 3) {
            // scissors cuts paper, computer wins
            result = 2;
        } else if (userChoice == 3 && computerChoice ==1) {
            // rock smashes scissors, computer wins
            result = 2;
        } else if (userChoice == 3 && computerChoice == 2) {
            // scissors cuts paper, user wins
            result = 1;
        }
        
        return result;
    }

}

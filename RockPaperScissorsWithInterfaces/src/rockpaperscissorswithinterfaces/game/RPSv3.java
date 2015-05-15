/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.game;

import java.util.Random;
import rockpaperscissorswithinterfaces.data.RPSChoice;
import rockpaperscissorswithinterfaces.data.RPSComputerChooser;
import rockpaperscissorswithinterfaces.data.RPSGameInfov1;
import rockpaperscissorswithinterfaces.data.RPSGameInfov2;

/**
 *
 * @author apprentice
 */
public class RPSv3 {
    
    RPSComputerChooser chooser;
    
    public RPSv3(RPSComputerChooser chooserIn) {
        chooser = chooserIn;
    }
    
    //this class plays one round of rock paper scissors
    
    public RPSGameInfov2 play(RPSChoice userChoice) {
        RPSChoice computerChoice = getComputerChoice();
        int result = checkWinner(userChoice, computerChoice);
        RPSGameInfov2 res = new RPSGameInfov2();
        res.setResult(result);
        res.setComputerChoice(computerChoice);
        res.setUserChoice(userChoice);
        return res;
    }
    
    // Rock = 1, Paper = 2, Scissors = 3
    // Tie = 0, User Wins = 1, Computer Wins = 2
    private int checkWinner(RPSChoice userChoice, RPSChoice computerChoice) {
        int result = 0;
        // tie
        if (userChoice == computerChoice) {
            result = 0;
        } else if (userChoice == RPSChoice.Rock && computerChoice == RPSChoice.Paper) {
            // paper covers rock, computer wins
            result = 2;
        } else if (userChoice == RPSChoice.Rock && computerChoice == RPSChoice.Scissors) {
            // rock smashes scissors, user wins
            result = 1;
        } else if (userChoice == RPSChoice.Paper && computerChoice == RPSChoice.Rock) {
            // paper covers rock, user wins
            result = 1;
        } else if (userChoice == RPSChoice.Paper && computerChoice == RPSChoice.Scissors) {
            // scissors cuts paper, computer wins
            result = 2;
        } else if (userChoice == RPSChoice.Scissors && computerChoice == RPSChoice.Rock) {
            // rock smashes scissors, computer wins
            result = 2;
        } else if (userChoice == RPSChoice.Scissors && computerChoice == RPSChoice.Paper) {
            // scissors cuts paper, user wins
            result = 1;
        }
        
        return result;
    }

    private RPSChoice getComputerChoice() {
        return chooser.getComputerChoice();
    }
    
}

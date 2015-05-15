/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.data;

import java.util.Random;

/**
 *
 * @author apprentice
 */
public class RandomComputerChooser implements RPSComputerChooser {

    @Override
    public RPSChoice getComputerChoice() {
        
        Random rGen = new Random();
        int computerChoice = rGen.nextInt(3) + 1;
        if (computerChoice == 1) {
            return RPSChoice.Rock;
        } else if (computerChoice == 2) {
            return RPSChoice.Paper;
        } else {
            return RPSChoice.Scissors;
        }
    
        
    }
    
}

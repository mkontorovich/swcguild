/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.ui;

import rockpaperscissorswithinterfaces.data.RPSChoice;
import rockpaperscissorswithinterfaces.data.RPSGameInfov1;
import rockpaperscissorswithinterfaces.data.RPSGameInfov2;
import rockpaperscissorswithinterfaces.data.RandomComputerChooser;
import rockpaperscissorswithinterfaces.game.RPSv1;
import rockpaperscissorswithinterfaces.game.RPSv2;
import rockpaperscissorswithinterfaces.game.RPSv3;

/**
 *
 * @author apprentice
 */
public class RockPaperScissorsWithInterfaces {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        RPSv1 rpsv1 = new RPSv1();
        RPSGameInfov1 result = rpsv1.play(1);
        System.out.println("Result = " + result.getResult());
        System.out.println("Computer Choice: " + result.getComputerChoice());
        System.out.println("User Choice: " + result.getUserChoice());
        
        RPSv2 rpsv2 = new RPSv2();
        RPSGameInfov2 result2 = rpsv2.play(RPSChoice.Rock);
        System.out.println("Result = " + result2.getResult());
        System.out.println("Computer Choice: " + result2.getComputerChoice());
        System.out.println("User Choice: " + result2.getUserChoice());
        
        RPSv3 rpsv3 = new RPSv3(new RandomComputerChooser());
        RPSGameInfov2 result3 = rpsv3.play(RPSChoice.Rock);
        System.out.println("Result = " + result3.getResult());
        System.out.println("Computer Choice: " + result3.getComputerChoice());
        System.out.println("User Choice: " + result3.getUserChoice());
    }
    
}
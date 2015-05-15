/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.data;

/**
 *
 * @author apprentice
 */
public class RPSGameInfov2 {
    //who won the round, what user choice was, what computer choice was
    
    private RPSChoice userChoice;
    private RPSChoice computerChoice;
    private int result;

    public RPSChoice getUserChoice() {
        return userChoice;
    }

    public void setUserChoice(RPSChoice userChoice) {
        this.userChoice = userChoice;
    }

    public RPSChoice getComputerChoice() {
        return computerChoice;
    }

    public void setComputerChoice(RPSChoice computerChoice) {
        this.computerChoice = computerChoice;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }


}

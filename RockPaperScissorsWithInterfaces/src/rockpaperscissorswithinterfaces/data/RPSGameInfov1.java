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
public class RPSGameInfov1 {
    //who won the round, what user choice was, what computer choice was
    
    private int userChoice;
    private int computerChoice;
    private int result;

    public int getUserChoice() {
        return userChoice;
    }

    public void setUserChoice(int userChoice) {
        this.userChoice = userChoice;
    }

    public int getComputerChoice() {
        return computerChoice;
    }

    public void setComputerChoice(int computerChoice) {
        this.computerChoice = computerChoice;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
    
    
}

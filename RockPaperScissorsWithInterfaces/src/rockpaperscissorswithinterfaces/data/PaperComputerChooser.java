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
public class PaperComputerChooser implements RPSComputerChooser {

    @Override
    public RPSChoice getComputerChoice() {
        return RPSChoice.Paper;
    }
    
}

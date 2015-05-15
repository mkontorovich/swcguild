/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rockpaperscissorswithinterfaces.game;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import rockpaperscissorswithinterfaces.data.RPSChoice;
import rockpaperscissorswithinterfaces.data.RPSGameInfov2;
import rockpaperscissorswithinterfaces.data.RockComputerChooser;

/**
 *
 * @author apprentice
 */
public class RPSv3Test {
    
    public RPSv3Test() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }


    @Test
    public void rockTest() {
        RPSv3 rps = new RPSv3(new RockComputerChooser());
        RPSGameInfov2 res = rps.play(RPSChoice.Rock);
        assertEquals(res.getResult(), 0);
        
    }
}

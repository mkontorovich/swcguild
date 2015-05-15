/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classroster;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author apprentice
 */
public class ClassRoster {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
            RosterBook myClass = new RosterBook();
            //create a new student
            Student s1 = new Student("0001");
            s1.setFirstName("John");
            s1.setLastName("Doe");
            s1.setCohort("Java-Jan2014");
            
            //add student to the roster book
            myClass.addStudent(s1.getStudentId(), s1);
            
            //quick test to verify that the add worked
            Student temp = myClass.getStudent("0001");
            System.out.println(temp.getFirstName());
        try {    
            //write rosterbook to file
            myClass.writeRoster();
        } catch (IOException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        }
        
        //now make sure we wrote to the file correctly
        RosterBook testRoster = new RosterBook();
        try {
            testRoster.loadRoster();
            Student testStudent = testRoster.getStudent("0001");
            System.out.println("Student from file: " + testStudent.getFirstName());
        } catch (FileNotFoundException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        }
        
    }
    
}

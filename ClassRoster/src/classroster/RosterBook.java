/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classroster;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Scanner;
import java.util.Set;

/**
 *
 * @author apprentice
 */
public class RosterBook {
    
    public static final String ROSTER_FILE = "roster.txt";
    
    public static final String DELIMITER = "::";
    
    private HashMap<String, Student> students = new HashMap<>();
    
    public void loadRoster() throws FileNotFoundException {
        //create scanner for reading the file
        Scanner sc = new Scanner(new BufferedReader(new FileReader(ROSTER_FILE)));
        //currentLine holds the most recent line read from the file
        String currentLine;
        
        String[] currentTokens;
        // Go through the ROSTER_FILE line by line, decode each line into a 
        // Student TER
        // process while we have more lines in the file
        while(sc.hasNextLine()) {
            //get the next line in the file
            currentLine = sc.nextLine();
            //break up line into tokens
            currentTokens = currentLine.split(DELIMITER);
            // create a new Student object and put it into the map of students
            
            Student currentStudent = new Student(currentTokens[0]);
            //set the remaining values on currentSTudent manually
            currentStudent.setFirstName(currentTokens[1]);
            currentStudent.setLastName(currentTokens[2]);
            currentStudent.setCohort(currentTokens[3]);
            
            //put currentStudent into the map using studentId as the key
            students.put(currentStudent.getStudentId(), currentStudent);
        }
        //close scanner
        sc.close();
    }
    
    public void writeRoster() throws IOException {
        PrintWriter out = new PrintWriter(new FileWriter(ROSTER_FILE));
        
        String[] keys = this.getAllStudentIds();
        
        //go through the keys one by one and get the corresponding
        //Student object
        
        for (int i = 0; i < keys.length; i++) {
        //get the Student object
        Student currentStudent = this.getStudent(keys[i]);
        //Write Student object to the file
        out.println(currentStudent.getStudentId() + DELIMITER + 
                currentStudent.getFirstName() + DELIMITER + 
                currentStudent.getLastName() + DELIMITER + 
                currentStudent.getCohort());
        
        out.flush();
    }
        out.close();
    }
    
    /**
     * 
     * @param studentId
     * @return 
     */
    public Student getStudent(String studentId) { 
        return students.get(studentId);
    }
    
    public Student addStudent(String studentId, Student student) {
        return students.put(studentId, student);
    }
    
    public Student removeStudent(String studentId) {
        return students.remove(studentId);
    }
    
    public String[] getAllStudentIds() {
        Set<String> keySet = students.keySet();
        String[] keyArray = new String[keySet.size()];
        keyArray = keySet.toArray(keyArray);
        return keyArray;
    }
}
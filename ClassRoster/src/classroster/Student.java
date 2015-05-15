/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classroster;

/**
 *Domain/data class for the Class Roster application. Holds all
 * information about a student. This doman class is used by both the 
 * ClassRoster and RosterBook classes to accomplish their respective tasks
 * 
 * 
 */
public class Student {
    private String firstName;
    private String lastName;
    private String studentId;
    private String cohort; // Java or .NET + cohort month/year
    
    
    
    public Student(String studentIdIn) {
        studentId = studentIdIn;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getCohort() {
        return cohort;
    }

    public void setCohort(String cohort) {
        this.cohort = cohort;
    }

    
    
}

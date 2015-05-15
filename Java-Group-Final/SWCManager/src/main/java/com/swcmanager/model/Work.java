/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.swcmanager.model;
import java.util.Date;
/**
 * Holds the all the work information for a single job.    The Student object 
 * will have an ArrayList of Work objects to hold all the work history for the
 * Student.
 * 
 * @author daniel
 */
public class Work {
    int workdId;
    int employerId;
    private int studentId;
    String companyName;
    String note;
    Date startDate;
    Date endDate;

    // Getters and setters
    public int getWorkdId() {
        return workdId;
    }

    public void setWorkdId(int workdId) {
        this.workdId = workdId;
    }
        
    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
}

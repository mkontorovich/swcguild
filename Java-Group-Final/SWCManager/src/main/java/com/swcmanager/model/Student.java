/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.swcmanager.model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Holds all the student information.  Contains ArrayLists for information from
 * the payment and work history.
 * 
 * @author daniel
 */
public class Student {
    
    int studentId;
    String firstName;
    String lastName;
    String street;
    String city;
    String state;
    String zipCode;
    String phone;
    String email;
    Date applicationDate;
    int testScore;
    Cohort cohort;
    Boolean housing;
    String status;
    String bioLink;
    String resumeLink;
    ArrayList<Payment> payments;
    ArrayList<Work> workHistory;
    
    // Getters and setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
    }

    public int getTestScore() {
        return testScore;
    }

    public void setTestScore(int testScore) {
        this.testScore = testScore;
    }

    public Cohort getCohort() {
        return cohort;
    }

    public void setCohort(Cohort cohort) {
        this.cohort = cohort;
    }

    public Boolean isHousing() {
        return housing;
    }
    
    public Boolean getHousing() {
        return housing;
    }

    public void setHousing(Boolean housing) {
        this.housing = housing;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBioLink() {
        return bioLink;
    }

    public void setBioLink(String bioLink) {
        this.bioLink = bioLink;
    }

    public String getResumeLink() {
        return resumeLink;
    }

    public void setResumeLink(String resumeLink) {
        this.resumeLink = resumeLink;
    }

    public ArrayList<Payment> getPayments() {
        return payments;
    }

    public void setPayments(ArrayList<Payment> payments) {
        this.payments = payments;
    }

    public ArrayList<Work> getWorkHistory() {
        return workHistory;
    }

    public void setWorkHistory(ArrayList<Work> workHistory) {
        this.workHistory = workHistory;
    }
    
}

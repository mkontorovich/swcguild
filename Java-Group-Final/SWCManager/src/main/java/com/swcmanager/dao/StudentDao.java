/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.swcmanager.dao;

import com.swcmanager.model.Payment;
import com.swcmanager.model.Student;
import com.swcmanager.model.Work;

/**
 * Provides DAO operations for Student model object.  Handles adding, deleting, 
 * updating, retrieving an individual student, retrieving a map of all students,
 * number of student records and searching of student records.  
 * 
 * @author daniel
 */
public interface StudentDao {
    
    public String[] getStatuses();
    
    public Student addStudent(Student student);
    
    public Student removeStudent(int studentId);
    
    public Student getStudent(int studentId);
    
    public Student[] getAllStudents();
    
    public void updateStudent(Student student, int cohortId);
    
    public Work[] getWorkForStudent(int studentId);
    
    public Payment[] getPaymentsForStudent(int studentId);
    
    public Work addNewWork(Work work);
    
    public Payment addNewPayment(Payment payment);
    
    public Work getWorkById(int workId);
    
    public Payment getPaymentById(int paymentId);
    
    public void deleteWork(int workId);
    
    public void deletePayment(int paymentId);
    
    public void updatePayment(Payment payment);
    
    public void updateWork(Work work);
}

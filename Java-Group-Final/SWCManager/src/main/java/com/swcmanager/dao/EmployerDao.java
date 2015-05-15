/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Employer;
import com.swcmanager.model.Contact;

/**
 *
 * @author apprentice
 */
public interface EmployerDao {

    public Employer addEmployer(Employer newEmployer);

    public void removeEmployer(int employerId);

    public void editEmployer(Employer employer);

    public Employer getEmployerById(int employerId);

    public Employer[] getAllEmployers();

    public Contact addContact(Contact newContact);

    public void removeContact(int contactId);
    
    public Contact[] getContactByEmployerId(int EmployerId);
    
    public Contact getContactById(int contactId);

    public String[] getEmployerStatuses();

    public String[] getEmployerTiers();

}

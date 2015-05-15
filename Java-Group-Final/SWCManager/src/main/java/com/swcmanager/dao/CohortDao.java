/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Cohort;

/**
 *
 * @author apprentice
 */
public interface CohortDao {

    public void deleteCohort(int cohortId);

    public Cohort addCohort(Cohort cohort);

    public Cohort[] displayCohorts();

    public Cohort getCohort(int cohorId);
    
    public void updateCohort(Cohort cohort);
}

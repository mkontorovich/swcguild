/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Cohort;
import java.util.Calendar;
import java.util.Date;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author apprentice
 */
public class CohortDaoTest {

    CohortDao dao;
    
    public CohortDaoTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {

        ApplicationContext ctx = new ClassPathXmlApplicationContext("test-applicationContext.xml");
        dao = (CohortDao) ctx.getBean("cohortDao");

        JdbcTemplate cleaner = (JdbcTemplate) ctx.getBean("jdbcTemplate");
        cleaner.execute("DELETE FROM cohorts");

    }

    @After
    public void tearDown() {
    }

    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    @Test
    public void addGetDeleteCohort() {

        Cohort co = new Cohort();
        
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, Calendar.DECEMBER);
        cal.set(Calendar.DATE, 24);
        cal.set(Calendar.YEAR, 2013);

        co.setStartDate(cal.getTime());
        co.setTrack("Java");
        
        //add the created cohort into the database.
        dao.addCohort(co); 
        
        
        //test the get cohort from the database 
        Cohort coFromDb = dao.getCohort(co.getCohortId());
        
        assertEquals(co.getCohortId(),coFromDb.getCohortId());
        assertEquals(co.getCohortId(),coFromDb.getCohortId());
        assertEquals(co.getCohortId(),coFromDb.getCohortId());
        
        
        //test the delete functionality
        dao.deleteCohort(co.getCohortId());
        
        assertNull(dao.getCohort(co.getCohortId()));
                
    }
    
    @Test
    public void getAllTest(){
        Cohort co = new Cohort();
        
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, Calendar.DECEMBER);
        cal.set(Calendar.DATE, 24);
        cal.set(Calendar.YEAR, 2013);

        co.setStartDate(cal.getTime());
        co.setTrack("Java");
        
        Cohort co1 = new Cohort();
        co1.setStartDate(cal.getTime());
        co1.setTrack("Java");
        
         //add the cohorts to the database
        dao.addCohort(co);
        dao.addCohort(co1);
        
        //attempt to pull all the cohorts from the database
        Cohort[] cos = dao.displayCohorts();
        
        assertEquals(cos.length,2);
        
    }
    
    @Test
    public void updateCohortTest(){
        Cohort co = new Cohort();
        
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, Calendar.DECEMBER);
        cal.set(Calendar.DATE, 24);
        cal.set(Calendar.YEAR, 2013);

        co.setStartDate(cal.getTime());
        co.setTrack("Java");
        
        //add the created cohort into the database.
        dao.addCohort(co);
        
        cal.set(Calendar.YEAR, 2014);
        Date time = (cal.getTime());
        co.setStartDate(time);
        co.setTrack(".NET");
        
        // update the cohort with new information
        dao.updateCohort(co);
        
        // test to see if the new information is what is stored in the database
        
        Cohort updatedCo = dao.getCohort(co.getCohortId());
        
        assertEquals(updatedCo.getStartDate().toString(), "2014-12-24");
        assertEquals(updatedCo.getTrack(), ".NET");
    }

}

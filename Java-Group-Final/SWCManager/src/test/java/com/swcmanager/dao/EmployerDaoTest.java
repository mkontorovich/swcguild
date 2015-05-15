/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Employer;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author apprentice
 */
public class EmployerDaoTest {

    private EmployerDao employerDao;

    public EmployerDaoTest() {
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
        employerDao = (EmployerDao) ctx.getBean("employerDao");

        JdbcTemplate cleaner = (JdbcTemplate) ctx.getBean("jdbcTemplate");
        cleaner.execute("delete from employers");

    }

    @After
    public void tearDown() {
    }

    @Test
    public void addGetDeleteEmployer() {

        Employer emp = new Employer();
        emp.setEmployerId(99);
        emp.setCompanyName("ABC Co.");
        emp.setTier("1");
        emp.setStatus("blah");
        emp.setCompanyPhone("6145551212");
        emp.setCompanyEmail("abc@abc.com");
        emp.setCompanyAddress("401 Smith St.");

        employerDao.addEmployer(emp);

        Employer fromDb = employerDao.getEmployerById(emp.getEmployerId());

        assertEquals(fromDb.getEmployerId(), emp.getEmployerId());
        assertEquals(fromDb.getCompanyName(), emp.getCompanyName());
        assertEquals(fromDb.getTier(), emp.getTier());
        assertEquals(fromDb.getStatus(), emp.getStatus());
        assertEquals(fromDb.getCompanyPhone(), emp.getCompanyPhone());
        assertEquals(fromDb.getCompanyEmail(), emp.getCompanyEmail());
        assertEquals(fromDb.getCompanyAddress(), emp.getCompanyAddress());

        employerDao.removeEmployer(emp.getEmployerId());

        assertNull(employerDao.getEmployerById(emp.getEmployerId()));
    }

    //
    // @Test
    // public void hello() {}
}

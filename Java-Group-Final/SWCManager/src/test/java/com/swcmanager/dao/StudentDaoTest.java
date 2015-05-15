/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Cohort;
import com.swcmanager.model.Employer;
import com.swcmanager.model.Payment;
import com.swcmanager.model.Student;
import com.swcmanager.model.Work;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
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
 * @author daniel
 */
public class StudentDaoTest {

    private StudentDao dao;
    private CohortDao cohortDao;
    private EmployerDao employerDao;

    public StudentDaoTest() {
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
        dao = (StudentDao) ctx.getBean("studentDao");
        cohortDao = (CohortDao) ctx.getBean("cohortDao");
        employerDao = (EmployerDao) ctx.getBean("employerDao");

        JdbcTemplate cleaner = (JdbcTemplate) ctx.getBean("jdbcTemplate");
        
        cleaner.execute("delete from work");
        cleaner.execute("delete from payments");
        cleaner.execute("delete from cohorts");
        cleaner.execute("delete from students");

    }

    @After
    public void tearDown() {
    }

    @Test
    public void testAddRemoveGetStudent() {
        // insert cohort
        Cohort co = new Cohort();
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, Calendar.DECEMBER);
        cal.set(Calendar.DATE, 24);
        cal.set(Calendar.YEAR, 2013);
        co.setStartDate(cal.getTime());
        co.setTrack("Java");
        
        //add the created cohort into the database.
        cohortDao.addCohort(co); 

        // insert employer
        Employer emp = new Employer();
        emp.setEmployerId(99);
        emp.setCompanyName("ABC Co.");
        emp.setTier("1");
        emp.setStatus("blah");
        emp.setCompanyPhone("6145551212");
        emp.setCompanyEmail("abc@abc.com");
        emp.setCompanyAddress("401 Smith St.");

        employerDao.addEmployer(emp);

        // create payments
        ArrayList<Payment> payments = new ArrayList<>();
        Payment pay1 = new Payment();
        pay1.setAmount(new BigDecimal(100));
        pay1.setNote("Payment 1");

        Payment pay2 = new Payment();
        pay2.setAmount(new BigDecimal(200));
        pay2.setNote("Payment 2");

        payments.add(pay1);
        payments.add(pay2);

        // create work history
        ArrayList<Work> workHistory = new ArrayList<>();
        Work work1 = new Work();
        work1.setCompanyName("ABC Co.");
        work1.setEmployerId(emp.getEmployerId());
        work1.setEndDate(cal.getTime());
        work1.setNote("Work History 1");
        work1.setStartDate(cal.getTime());
        
        workHistory.add(work1);

        // insert student
        Student s = new Student();
        s.setApplicationDate(cal.getTime());
        s.setBioLink("biolink");
        s.setCity("city");
        s.setCohort(co);
        s.setEmail("john@gmail.com");
        s.setFirstName("John");
        s.setHousing(Boolean.TRUE);
        s.setLastName("Doe");
        s.setPayments(payments);
        s.setPhone("19999999999");
        s.setResumeLink("resumelink");
        s.setState("OH");
        s.setStreet("123 Test Ave");
        s.setStatus("Accepted");
        s.setTestScore(100);
        s.setWorkHistory(workHistory);
        s.setZipCode("48073");

        dao.addStudent(s);
        
        // get student and compare
        Student newS = dao.getStudent(s.getStudentId());
        assertEquals(s.getFirstName(), newS.getFirstName());
        //assertEquals(s.getApplicationDate(), newS.getApplicationDate());
        assertEquals(s.getBioLink(), newS.getBioLink());
        assertEquals(s.getCity(), newS.getCity());
        assertEquals(s.getCohort().getCohortId(), newS.getCohort().getCohortId());
        assertEquals(s.getEmail(), newS.getEmail());
        assertEquals(s.getHousing(), newS.getHousing());
        assertEquals(s.getLastName(), newS.getLastName());
        assertEquals(s.getPayments().get(0).getPaymentId(), newS.getPayments().get(0).getPaymentId());
        assertEquals(s.getPayments().get(0).getAmount(), newS.getPayments().get(0).getAmount());
        assertEquals(s.getPayments().get(0).getNote(), newS.getPayments().get(0).getNote());
        assertEquals(s.getPayments().get(1).getPaymentId(), newS.getPayments().get(1).getPaymentId());
        assertEquals(s.getPhone(), newS.getPhone());
        assertEquals(s.getResumeLink(), newS.getResumeLink());
        assertEquals(s.getState(), newS.getState());
        assertEquals(s.getStreet(), newS.getStreet());
        assertEquals(s.getStatus(), newS.getStatus());
        assertEquals(s.getTestScore(), newS.getTestScore());
        assertEquals(s.getWorkHistory().get(0).getWorkdId(), newS.getWorkHistory().get(0).getWorkdId());
        assertEquals(s.getWorkHistory().get(0).getEmployerId(), newS.getWorkHistory().get(0).getEmployerId());
        assertEquals(s.getWorkHistory().get(0).getCompanyName(), newS.getWorkHistory().get(0).getCompanyName());
        assertEquals(s.getWorkHistory().get(0).getNote(), newS.getWorkHistory().get(0).getNote());
        assertEquals(s.getZipCode(), newS.getZipCode());
        
        dao.addStudent(s);
        Student[] students = dao.getAllStudents();
        assertEquals(s.getFirstName(), students[0].getFirstName());
        
        // AI student_id
        // drop employor_id
        // change date of application to Date
        // remove extra index from payments table student_id column
        
        
        //test the update student functionality
        
        s.setApplicationDate(cal.getTime());
        s.setBioLink("biolink1");
        s.setCity("city1");
        s.setCohort(co);
        s.setEmail("john@gmail.com1");
        s.setFirstName("John1");
        s.setHousing(Boolean.FALSE);
        s.setLastName("Doe1");
        s.setPayments(payments);
        s.setPhone("999999999");
        s.setResumeLink("resumelink1");
        s.setState("OH1");
        s.setStreet("123 Test Ave1");
        s.setStatus("Accepted1");
        s.setTestScore(1001);
        s.setWorkHistory(workHistory);
        s.setZipCode("99999");
        
        //update the student 
        dao.updateStudent(s,co.getCohortId());
        
         // get student and compare
        newS = dao.getStudent(s.getStudentId());
        assertEquals(s.getFirstName(), newS.getFirstName());
        //assertEquals(s.getApplicationDate(), newS.getApplicationDate());
        assertEquals(s.getBioLink(), newS.getBioLink());
        assertEquals(s.getCity(), newS.getCity());
        assertEquals(s.getCohort().getCohortId(), newS.getCohort().getCohortId());
        assertEquals(s.getEmail(), newS.getEmail());
        assertEquals(s.getHousing(), newS.getHousing());
        assertEquals(s.getLastName(), newS.getLastName());
        assertEquals(s.getPayments().get(0).getPaymentId(), newS.getPayments().get(0).getPaymentId());
        assertEquals(s.getPayments().get(0).getAmount(), newS.getPayments().get(0).getAmount());
        assertEquals(s.getPayments().get(0).getNote(), newS.getPayments().get(0).getNote());
        assertEquals(s.getPayments().get(1).getPaymentId(), newS.getPayments().get(1).getPaymentId());
        assertEquals(s.getPhone(), newS.getPhone());
        assertEquals(s.getResumeLink(), newS.getResumeLink());
        assertEquals(s.getState(), newS.getState());
        assertEquals(s.getStreet(), newS.getStreet());
        assertEquals(s.getStatus(), newS.getStatus());
        assertEquals(s.getTestScore(), newS.getTestScore());
        assertEquals(s.getWorkHistory().get(0).getWorkdId(), newS.getWorkHistory().get(0).getWorkdId());
        assertEquals(s.getWorkHistory().get(0).getEmployerId(), newS.getWorkHistory().get(0).getEmployerId());
        assertEquals(s.getWorkHistory().get(0).getCompanyName(), newS.getWorkHistory().get(0).getCompanyName());
        assertEquals(s.getWorkHistory().get(0).getNote(), newS.getWorkHistory().get(0).getNote());
        assertEquals(s.getZipCode(), newS.getZipCode());
        
        
        
        //testing work dao functionalities functionality
        Work[] work = dao.getWorkForStudent(s.getStudentId());
        assertTrue(work.length == 1);
        //add
        dao.addNewWork(work1);
        //get
        Work work2 = dao.getWorkById(work1.getWorkdId());
        assertEquals(work1.getCompanyName(),work2.getCompanyName());
        assertEquals(work1.getEmployerId(),work2.getEmployerId());
        assertEquals(work1.getNote(),work2.getNote());
        assertEquals(work1.getStudentId(),work2.getStudentId());
        //delete
        dao.deleteWork(work1.getWorkdId());
        assertNull(dao.getWorkById(work1.getWorkdId()));
        
        
        //payments section of the dao test
        assertEquals(dao.getPaymentsForStudent(s.getStudentId()).length,2);
        
        pay2.setStudentId(20);
        pay2.setAmount(new BigDecimal("125"));
        pay2.setNote("Some information");
        //add the payment
        dao.addNewPayment(pay2);
        //get the payment and test the functionality
        Payment pay3 = dao.getPaymentById(pay2.getPaymentId());
        
        assertEquals(pay2.getAmount(),pay3.getAmount());
        assertEquals(pay2.getNote(),pay3.getNote());
        assertEquals(pay2.getStudentId(),pay3.getStudentId());
        
        //test the delete functionality for payment
        dao.deletePayment(pay2.getPaymentId());
        pay3 = dao.getPaymentById(pay2.getPaymentId());
        assertNull(pay3);
        
    }
}

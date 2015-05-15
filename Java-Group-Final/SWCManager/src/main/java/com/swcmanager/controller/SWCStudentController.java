package com.swcmanager.controller;

import com.swcmanager.dao.CohortDao;
import com.swcmanager.dao.EmployerDao;
import com.swcmanager.dao.StudentDao;
import com.swcmanager.model.Cohort;
import com.swcmanager.model.Employer;
import com.swcmanager.model.Payment;
import com.swcmanager.model.Student;
import com.swcmanager.model.Work;
import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author daniel
 */
@Controller
public class SWCStudentController {

    private StudentDao studentDao;
    private CohortDao cohortDao;
    private EmployerDao employerDao;
//    //used to make the modal popup should someone want to edit the student
//    private String popupStudent="false";
//    private Student editStudent = new Student();

    @Inject
    public SWCStudentController(StudentDao studentDao, CohortDao cohortDao, EmployerDao employerDao) {
        // gets DAO bean from Spring
        this.studentDao = studentDao;
        this.cohortDao = cohortDao;
        this.employerDao = employerDao;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping(value = {"/studentList"}, method = RequestMethod.GET)
    public String displayStudents(Map<String, Object> model) {
        model.put("students", studentDao.getAllStudents());
        Student newStudent = new Student();
        model.put("newStudent", newStudent);

        Cohort[] cohortList = cohortDao.displayCohorts();
        Employer[] employerList = employerDao.getAllEmployers();

        model.put("statuses", studentDao.getStatuses());
        model.put("cohortList", cohortList);
        model.put("employerList", employerList);
//        model.put("popupEditStudent", popupStudent);
//        model.put("editStudent", editStudent);

        return "displayStudentList";
    }

    @RequestMapping(value = "/deleteStudent", method = RequestMethod.GET)
    public String deleteStudent(@RequestParam("studentId") String id,
            Map<String, Object> model) {

        studentDao.removeStudent(Integer.parseInt(id));

        return "redirect:studentList";
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    public String addStudent(Map<String, Object> model, HttpServletRequest req,
            HttpServletResponse res) throws ParseException {
        Student student = new Student();

        student.setApplicationDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("applicationDate")));
        student.setBioLink(req.getParameter("bioLink"));
        student.setCity(req.getParameter("city"));
        student.setEmail(req.getParameter("email"));
        student.setFirstName(req.getParameter("firstName"));
        String housingString = req.getParameter("housing");
        if (housingString.equals("TRUE")) {
            student.setHousing(TRUE);
        } else if (housingString.equals("FALSE")) {
            student.setHousing(FALSE);
        }

        student.setLastName(req.getParameter("lastName"));
        student.setPhone(req.getParameter("phone"));
        student.setResumeLink(req.getParameter("resumeLink"));
        student.setState(req.getParameter("state"));
        student.setStreet(req.getParameter("street"));
        student.setStatus(req.getParameter("status"));
        student.setTestScore(Integer.parseInt(req.getParameter("testScore")));
        student.setZipCode(req.getParameter("zipCode"));

        Cohort cohort = cohortDao.getCohort(Integer.parseInt(req.getParameter("cohort")));

        ArrayList<Work> workHistory = new ArrayList<>();

        String[] employerArray = req.getParameterValues("employer[]");
        String[] startArray = req.getParameterValues("startDate[]");
        if (!startArray[0].equals("")) {
            String[] endArray = req.getParameterValues("endDate[]");
            String[] workNoteArray = req.getParameterValues("workNote[]");

            for (int i = 0; i < employerArray.length; i++) {
                Work work = new Work();
                work.setEmployerId(Integer.parseInt(employerArray[i]));
                work.setEndDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(endArray[i]));
                work.setStartDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(startArray[i]));
                work.setNote(workNoteArray[i]);

                workHistory.add(work);
            }
        }

        ArrayList<Payment> payments = new ArrayList<>();
        String[] amountArray = req.getParameterValues("amount[]");
        String[] payNoteArray = req.getParameterValues("payNote[]");

        for (int i = 0; i < amountArray.length; i++) {
            Payment payment = new Payment();
            payment.setAmount(new BigDecimal(amountArray[i]));
            payment.setNote(payNoteArray[i]);
            payments.add(payment);
        }

        student.setCohort(cohort);
        student.setWorkHistory(workHistory);
        student.setPayments(payments);

        studentDao.addStudent(student);

        //return to the main display page
        return "redirect:studentList";
    }

    //displays the edit student form page
    @RequestMapping(value = "/displayEditStudent", method = RequestMethod.GET)
    public String editStudent(Map<String, Object> model,
            @RequestParam("studentId") String id,
            HttpSession session) {

        //if payment update isn't happening, initilize a payment so the modal doesn't error out
        if (session.getAttribute("paymentId") == null) {
            Payment payment = new Payment();
            payment.setAmount(new BigDecimal("25"));
            payment.setNote("");
            payment.setPaymentId(0);
            payment.setStudentId(0);
            model.put("updatePayment", payment);
            model.put("popupUpdatePayment", false);
        } else {
            Payment payment = studentDao.getPaymentById(Integer.parseInt(session.getAttribute("paymentId").toString()));
            model.put("updatePayment", payment);
            model.put("popupUpdatePayment", true);
        }

        //if work update isn't happening, initilize a work so the modal doesn't error out
        if (session.getAttribute("workId") == null) {

            Work work = new Work();
            work.setCompanyName("");
            work.setEmployerId(0);
            work.setEndDate(new Date(2012 - 01 - 01));
            work.setNote("");
            work.setStartDate(new Date(2012 - 01 - 01));
            work.setStudentId(0);
            model.put("updateWork", work);
            model.put("popupUpdateWork", false);
        } else {
            Work work = studentDao.getWorkById(Integer.parseInt(session.getAttribute("workId").toString()));
            model.put("updateWork", work);
            model.put("popupUpdateWork", true);
        }

        int studId = Integer.parseInt(id);
        Student student = studentDao.getStudent(studId);
        //stores the student in session for later use
        session.setAttribute("studentId", id);

        //load up the model
        Cohort[] cohortList = cohortDao.displayCohorts();
        Employer[] employerList = employerDao.getAllEmployers();
        Payment[] payments = studentDao.getPaymentsForStudent(Integer.parseInt(id));
        Work[] works = studentDao.getWorkForStudent(Integer.parseInt(id));

        model.put("payments", payments);
        model.put("works", works);
        model.put("addStudent", student);
        model.put("statuses", studentDao.getStatuses());
        model.put("cohortList", cohortList);
        model.put("employerList", employerList);

        return "updateStudentForm";
    }

    @RequestMapping(value = "/updateStudent", method = RequestMethod.POST)
    public String editStudent(HttpServletRequest req) throws ParseException {

        Student student = new Student();

        student.setApplicationDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("applicationDate")));
        student.setBioLink(req.getParameter("bioLink"));
        student.setCity(req.getParameter("city"));
        student.setEmail(req.getParameter("email"));
        student.setFirstName(req.getParameter("firstName"));
        String housingString = req.getParameter("housing");
        if (housingString.equals("TRUE")) {
            student.setHousing(TRUE);
        } else if (housingString.equals("FALSE")) {
            student.setHousing(FALSE);
        }

        student.setLastName(req.getParameter("lastName"));
        student.setPhone(req.getParameter("phone"));
        student.setResumeLink(req.getParameter("resumeLink"));
        student.setState(req.getParameter("state"));
        student.setStreet(req.getParameter("street"));
        student.setStatus(req.getParameter("status"));
        student.setTestScore(Integer.parseInt(req.getParameter("testScore")));
        student.setZipCode(req.getParameter("zipCode"));
        student.setStudentId(Integer.parseInt(req.getParameter("uStudentId")));

        int cohortId = Integer.parseInt(req.getParameter("cohort"));

        //student update dao stuff
        studentDao.updateStudent(student, cohortId);

        return "redirect:studentList";
    }

    //used to add another work history to a student
    @RequestMapping(value = "/addWork", method = RequestMethod.POST)
    public String addWork(HttpServletRequest req) throws ParseException {

        Work work = new Work();
        work.setEmployerId(Integer.parseInt(req.getParameter("employer")));
        work.setEndDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("startDate")));
        work.setStartDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("endDate")));
        work.setNote(req.getParameter("workNote"));
        work.setStudentId(Integer.parseInt(req.getParameter("studentId")));

        studentDao.addNewWork(work);

        return "redirect:studentList";
    }

    //used to delete a work history that's attached to a student
    @RequestMapping(value = "/removeWork", method = RequestMethod.GET)
    public String deleteWork(HttpServletRequest req,
            @RequestParam("workId") int id,
            HttpSession session) {

        studentDao.deleteWork(id);

        //makes sure that the session work attribute can't be the value of the deleted parameter
        if (session.getAttribute("workId") != null) {
            session.setAttribute("workId", null);
        }

        return "redirect:studentList";
    }

    //used to add another pay history to a student
    @RequestMapping(value = "/addPayment", method = RequestMethod.POST)
    public String addPayment(HttpServletRequest req) throws ParseException {

        Payment payment = new Payment();
        payment.setAmount(new BigDecimal(req.getParameter("amount")));
        payment.setNote(req.getParameter("note"));
        String something = req.getParameter("studentId");
        int studId = Integer.parseInt(something);
        payment.setStudentId(studId);

        studentDao.addNewPayment(payment);

        return "redirect:studentList";
    }

    //used to delete a payment that's attached to a student
    @RequestMapping(value = "/removePayment", method = RequestMethod.GET)
    public String deletePayment(HttpServletRequest req,
            @RequestParam("paymentId") int id,
            HttpSession session) {

        studentDao.deletePayment(id);

        //makes sure that the session payment attribute can't be the value of the deleted parameter
        if (session.getAttribute("paymentId") != null) {
            session.setAttribute("paymentId", null);
        }

        return "redirect:studentList";
    }

    @RequestMapping(value = "/displayUpdatePayment", method = RequestMethod.GET)
    public String displayUpdatePayment(HttpSession session,
            @RequestParam("paymentId") String id) {

        session.setAttribute("paymentId", id);

        return "redirect:displayEditStudent?studentId=" + session.getAttribute("studentId");
    }

    @RequestMapping(value = "/displayUpdateWork", method = RequestMethod.GET)
    public String displayUpdateWork(HttpSession session,
            @RequestParam("workId") String id) {

        session.setAttribute("workId", id);

        return "redirect:displayEditStudent?studentId=" + session.getAttribute("studentId");
    }

    //updates work. uses session variable from display update work to determine the work id
    @RequestMapping(value = "/updateWork", method = RequestMethod.POST)
    public String updateWork(HttpServletRequest req,
            HttpSession session) throws ParseException {

        Work work = new Work();
        work.setEmployerId(Integer.parseInt(req.getParameter("uEmployer")));
        work.setEndDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("uStartDate")));
        work.setStartDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("uEndDate")));
        work.setNote(req.getParameter("uWorkNote"));
        work.setStudentId(Integer.parseInt(req.getParameter("uStudentId")));
        String string = session.getAttribute("workId").toString();
        work.setWorkdId(Integer.parseInt(session.getAttribute("workId").toString()));

        //turns off the modal
        session.setAttribute("workId", null);

        studentDao.updateWork(work);

        return "redirect:displayEditStudent?studentId=" + work.getStudentId();

    }

    //updates work. uses session variable from display update work to determine the work id
    @RequestMapping(value = "/updatePayment", method = RequestMethod.POST)
    public String updatePayment(HttpServletRequest req,
            HttpSession session) throws ParseException {

        Payment payment = new Payment();
        payment.setAmount(new BigDecimal(req.getParameter("uAmount")));
        payment.setNote(req.getParameter("uPayNote"));
        payment.setStudentId(Integer.parseInt(req.getParameter("uPayStudentId")));
        payment.setPaymentId(Integer.parseInt(session.getAttribute("paymentId").toString()));

        //turns off the modal
        session.setAttribute("paymentId", null);

        studentDao.updatePayment(payment);

        return "redirect:displayEditStudent?studentId=" + payment.getStudentId();

    }

}

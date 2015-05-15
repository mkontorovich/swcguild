/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Cohort;
import com.swcmanager.model.Payment;
import com.swcmanager.model.Student;
import com.swcmanager.model.Work;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

/**
 *
 * @author daniel
 */
public class StudentDaoDbImpl implements StudentDao {

    private final static String SQL_INSERT_STUDENT
            = "INSERT INTO students (first_name, last_name, street, city,"
            + "state, zip_code, phone, email, date_of_application, aptitude_test_score,"
            + "cohort_id, housing, status, student_bio, student_resume) "
            + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    private final static String SQL_REMOVE_STUDENT
            = "DELETE FROM students WHERE student_id=?";

    private final static String SQL_INSERT_WORK
            = "INSERT INTO work (employer_id, student_id, start_date,"
            + "end_date,note) VALUES (?,?,?,?,?)";

    private final static String SQL_UPDATE_WORK
            = "UPDATE work SET employer_id=?, student_id=?, start_date=?,"
            + " end_date=?,note=? WHERE work_id=?";

    private final static String SQL_REMOVE_WORK
            = "DELETE FROM work WHERE work_id=?";

    private final static String SQL_INSERT_PAYMENT
            = "INSERT INTO payments (amount, note, student_id)"
            + " VALUES (?,?,?)";

    private final static String SQL_UPDATE_PAYMENT
            = "UPDATE payments SET amount=?, note=?, student_id=?"
            + " WHERE payments_id=?";

    private final static String SQL_REMOVE_PAYMENT
            = "DELETE FROM payments WHERE payments_id=?";

    private final static String SQL_GET_STUDENT
            = "SELECT * FROM students WHERE student_id=?";

    private final static String SQL_GET_ALL_STUDENTS
            = "SELECT * FROM students";

    private final static String SQL_GET_WORK_HISTORY
            = "SELECT * FROM work INNER JOIN employers ON employers.employer_ID=work.employer_ID WHERE student_id=?";

    private final static String SQL_GET_WORK
            = "SELECT * FROM work INNER JOIN employers ON employers.employer_ID=work.employer_ID WHERE work_id=?";

    private final static String SQL_DELETE_WORK
            = "DELETE FROM work WHERE work_id=?";

    private final static String SQL_GET_PAYMENTS
            = "SELECT * FROM payments WHERE student_id=?";

    private final static String SQL_GET_PAYMENT
            = "SELECT * FROM payments WHERE payments_id=?";

    private final static String SQL_DELETE_PAYMENT
            = "DELETE FROM payments WHERE payments_id =?";
    
    
    private final static String SQL_GET_COHORT
            = "SELECT * FROM cohorts WHERE cohort_id=?";

    private final static String SQL_GET_STATUSES
            = "SELECT * FROM student_statuses";

    private final static String SQL_UPDATE_STUDENT
            = "UPDATE students SET first_name=?, last_name=?, street=?, city=?,"
            + "state=?, zip_code=?, phone=?, email=?, date_of_application=?, aptitude_test_score=?,"
            + "cohort_id=?, housing=?, status=?, student_bio=?, student_resume=?"
            + "WHERE student_id =?";

    private JdbcTemplate jdbcTemplate;

    /**
     * Sets this.jdbcTemplate to the injected jdbcTemplate.
     *
     * @param jdbcTemplate
     */
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Retrieves all valid student statuses from database and returns them in a
     * String array.
     *
     * @return - String array of all valid student statuses
     */
    @Override
    public String[] getStatuses() {
        List<String> slist = jdbcTemplate.query(SQL_GET_STATUSES, new StatusMapper());
        return slist.toArray(new String[0]);
    }

    /**
     * Uses prepared statements to insert Student object into students table in
     * the database. Will check work and payments tables and insert entries if
     * necessary to maintain proper relational integrity.
     *
     * @param student - Student object to add to the database
     * @return - Student object that was added to the database
     */
    @Override
    public Student addStudent(Student student) {
        // insert into student table
        jdbcTemplate.update(SQL_INSERT_STUDENT, student.getFirstName(), student.getLastName(),
                student.getStreet(), student.getCity(), student.getState(), student.getZipCode(), student.getPhone(),
                student.getEmail(), student.getApplicationDate(), student.getTestScore(),
                student.getCohort().getCohortId(), student.isHousing(), student.getStatus(), student.getBioLink(),
                student.getResumeLink());

        // get auto increamented value from the database
        student.setStudentId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));

        // insert into work table
        for (int i = 0; i < student.getWorkHistory().size(); i++) {
            Work work = student.getWorkHistory().get(i);
            jdbcTemplate.update(SQL_INSERT_WORK, work.getEmployerId(), student.getStudentId(),
                    work.getStartDate(), work.getEndDate(), work.getNote());
            work.setWorkdId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));
        }

        // insert into payments table
        for (int i = 0; i < student.getPayments().size(); i++) {
            Payment payment = student.getPayments().get(i);
            jdbcTemplate.update(SQL_INSERT_PAYMENT, payment.getAmount(), payment.getNote(),
                    student.getStudentId());
            payment.setPaymentId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));
        }

        return student;
    }

    /**
     * Removes entry from students table referenced by student_id passed in.
     * Will also remove all work and payments entries that reference the
     * student_id.
     *
     * @param studentId - student_id for the entry to remove from the students
     * table
     * @return - Student object that was removed from the database
     */
    @Override
    public Student removeStudent(int studentId) {
        Student student = getStudent(studentId);

        // remove from payments table
        for (int i = 0; i < student.getPayments().size(); i++) {
            Payment payment = student.getPayments().get(i);
            jdbcTemplate.update(SQL_REMOVE_PAYMENT, payment.getPaymentId());
        }

        // remove from work table
        for (int i = 0; i < student.getWorkHistory().size(); i++) {
            Work work = student.getWorkHistory().get(i);
            jdbcTemplate.update(SQL_REMOVE_WORK, work.getWorkdId());
        }

        // remove from students table
        jdbcTemplate.update(SQL_REMOVE_STUDENT, student.getStudentId());

        return student;
    }

    /**
     * Retrieves a Student object from the database based on the studentId
     * passed to it.
     *
     * @param studentId - Id of the entry from the students table
     * @return - Student object with the requested studentId
     */
    @Override
    public Student getStudent(int studentId) {
        Student student = jdbcTemplate.queryForObject(SQL_GET_STUDENT, new StudentMapper(), studentId);

        return student;
    }

    /**
     * Retrieves all Student objects from the database based.
     *
     * @return - Array of all Student objects in the database
     */
    @Override
    public Student[] getAllStudents() {
        List<Student> studentList = jdbcTemplate.query(SQL_GET_ALL_STUDENTS, new StudentMapper());
        return studentList.toArray(new Student[0]);
    }

    //updates the the student, takes in both a student and the cohort id the student belongs to.
    @Override
    public void updateStudent(Student student, int cohortId) {
        jdbcTemplate.update(SQL_UPDATE_STUDENT, student.getFirstName(), student.getLastName(),
                student.getStreet(), student.getCity(), student.getState(), student.getZipCode(), student.getPhone(),
                student.getEmail(), student.getApplicationDate(), student.getTestScore(),
                cohortId,
                student.isHousing(), student.getStatus(), student.getBioLink(),
                student.getResumeLink(), student.getStudentId());
    }

    @Override
    public Work[] getWorkForStudent(int studentId) {

        return jdbcTemplate.query(SQL_GET_WORK_HISTORY, new WorkMapper(), studentId).toArray(new Work[0]);
    }

    @Override
    public Payment[] getPaymentsForStudent(int studentId) {

        return jdbcTemplate.query(SQL_GET_PAYMENTS, new PaymentMapper(), studentId).toArray(new Payment[0]);
    }

    @Override
    public Work addNewWork(Work work) {
        jdbcTemplate.update(SQL_INSERT_WORK, work.getEmployerId(), work.getStudentId(),
                work.getStartDate(), work.getEndDate(), work.getNote());
        work.setWorkdId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));

        return work;
    }

    @Override
    public Payment addNewPayment(Payment payment) {
        jdbcTemplate.update(SQL_INSERT_PAYMENT, payment.getAmount(), payment.getNote(),
                payment.getStudentId());
        payment.setPaymentId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));
        
        return payment;

    }

    @Override
    public Work getWorkById(int workId) {
        try {
            return jdbcTemplate.queryForObject(SQL_GET_WORK, new WorkMapper(), workId);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    public Payment getPaymentById(int paymentId) {
        try{
        return jdbcTemplate.queryForObject(SQL_GET_PAYMENT, new PaymentMapper(), paymentId);
        }catch(EmptyResultDataAccessException ex){
            return null;
        }
    }

    @Override
    public void deleteWork(int workId) {
        jdbcTemplate.update(SQL_DELETE_WORK, workId);
    }

    @Override
    public void deletePayment(int paymentId) {
        jdbcTemplate.update(SQL_DELETE_PAYMENT, paymentId);
    }

    @Override
    public void updatePayment(Payment payment) {
        jdbcTemplate.update(SQL_UPDATE_PAYMENT,
                payment.getAmount(),
                payment.getNote(),
                payment.getStudentId(),
                payment.getPaymentId());
    }

    @Override
    public void updateWork(Work work) {
        jdbcTemplate.update(SQL_UPDATE_WORK,
                work.getEmployerId(),
                work.getStudentId(),
                work.getStartDate(),
                work.getEndDate(),
                work.getNote(),
                work.getWorkdId());
    }

    /**
     * Maps Student Object to row result from students table. Work and Payment
     * ArrayLists will still need to be filled in.
     */
    private final class StudentMapper implements ParameterizedRowMapper<Student> {

        @Override
        public Student mapRow(ResultSet rs, int rowNum) throws SQLException {
            Student student = new Student();

            student.setStudentId(rs.getInt("student_id"));
            student.setFirstName(rs.getString("first_name"));
            student.setLastName(rs.getString("last_name"));
            student.setStreet(rs.getString("street"));
            student.setCity(rs.getString("city"));
            student.setState(rs.getString("state"));
            student.setZipCode(rs.getString("zip_code"));
            student.setPhone(rs.getString("phone"));
            student.setEmail(rs.getString("email"));
            student.setApplicationDate(rs.getDate("date_of_application"));
            student.setTestScore(rs.getInt("aptitude_test_score"));
            student.setHousing(rs.getBoolean("housing"));
            student.setStatus(rs.getString("status"));
            student.setBioLink(rs.getString("student_bio"));
            student.setResumeLink(rs.getString("student_resume"));
            Cohort cohort = new Cohort();
            cohort.setCohortId(rs.getInt("cohort_id"));
            student.setCohort(cohort);

            student.setCohort(jdbcTemplate.queryForObject(SQL_GET_COHORT, new CohortMapper(), student.getCohort().getCohortId()));
            student.setPayments(new ArrayList(jdbcTemplate.query(SQL_GET_PAYMENTS, new PaymentMapper(), student.getStudentId())));
            student.setWorkHistory(new ArrayList(jdbcTemplate.query(SQL_GET_WORK_HISTORY, new WorkMapper(), student.getStudentId())));

            return student;
        }
    }

    /**
     * Maps an ArrayList of Payment objects from result set from the payments
     * table.
     */
    private static final class PaymentMapper implements ParameterizedRowMapper<Payment> {

        @Override
        public Payment mapRow(ResultSet rs, int i) throws SQLException {
            Payment pay = new Payment();

            pay.setPaymentId(rs.getInt("payments_id"));
            pay.setAmount(rs.getBigDecimal("amount"));
            pay.setNote(rs.getString("note"));
            pay.setStudentId(rs.getInt("student_id"));

            return pay;
        }
    }

    /**
     * Maps an ArrayList of Work objects from the result set from the work
     * table.
     */
    private static final class WorkMapper implements ParameterizedRowMapper<Work> {

        @Override
        public Work mapRow(ResultSet rs, int i) throws SQLException {
            Work work = new Work();

            work.setWorkdId(rs.getInt("work_id"));
            work.setCompanyName(rs.getString("company_name"));
            work.setEmployerId(rs.getInt("employer_id"));
            work.setStartDate(rs.getDate("start_date"));
            work.setEndDate(rs.getDate("end_date"));
            work.setNote(rs.getString("note"));

            return work;
        }

        /**
         * Maps a Cohort from the result set from the cohort table.
         */
    }

    private static final class CohortMapper implements ParameterizedRowMapper<Cohort> {

        @Override
        public Cohort mapRow(ResultSet rs, int i) throws SQLException {
            Cohort cohort = new Cohort();

            cohort.setCohortId(rs.getInt("cohort_id"));
            cohort.setStartDate(rs.getDate("start_date"));
            cohort.setTrack(rs.getString("track"));

            return cohort;

        }
    }

    private static final class StatusMapper implements ParameterizedRowMapper<String> {

        @Override
        public String mapRow(ResultSet rs, int i) throws SQLException {
            String status = new String();

            status = (rs.getString("status"));

            return status;

        }

    }

}

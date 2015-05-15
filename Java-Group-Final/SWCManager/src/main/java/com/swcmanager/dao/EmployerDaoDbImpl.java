/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.Employer;
import com.swcmanager.model.Contact;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author apprentice
 */
public class EmployerDaoDbImpl implements EmployerDao {

    private static final String SQL_INSERT_EMPLOYER
            = "INSERT INTO employers (company_name, tier, status, company_phone, company_email, company_address) "
            + "VALUES (?,?,?,?,?,?)";
    private static final String SQL_REMOVE_EMPLOYER
            = "DELETE FROM employers WHERE employer_ID = ?";

    private static final String SQL_SELECT_EMPLOYER
            = "select * from employers where employer_ID = ?";

    private static final String SQL_SELECT_ALL_EMPLOYERS
            = "select * from employers";

    private static final String SQL_INSERT_CONTACT
            = "INSERT INTO contacts (employer_ID, first_name, last_name, phone, email, address, note) "
            + "VALUES (?,?,?,?,?,?,?)";
    private static final String SQL_REMOVE_CONTACT
            = "DELETE FROM contacts WHERE contact_ID = ?";
    
    private static final String SQL_GET_CONTACT_BY_ID
            = "select * from contacts where contact_ID = ?";

    private static final String SQL_GET_CONTACTS
            = "SELECT * from contacts WHERE employer_ID = ?";

    private static final String SQL_UPDATE_EMPLOYER
            = "update employers set company_name = ?, tier = ?, status = ?, company_phone = ?,"
            + "company_email = ?, company_address = ? where employer_ID = ?";

    private final static String SQL_GET_EMPLOYER_STATUSES
            = "SELECT * FROM employer_statuses";

    private final static String SQL_GET_TIERS
            = "SELECT * FROM tiers";

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Employer addEmployer(Employer newEmployer) {

        jdbcTemplate.update(SQL_INSERT_EMPLOYER, newEmployer.getCompanyName(),
                newEmployer.getTier(), newEmployer.getStatus(), newEmployer.getCompanyPhone(),
                newEmployer.getCompanyEmail(), newEmployer.getCompanyAddress());
        newEmployer.setEmployerId(jdbcTemplate.queryForObject("select LAST_INSERT_ID()", Integer.class));
        return newEmployer;
    }

    @Override
    public void removeEmployer(int employerId) {

        jdbcTemplate.update(SQL_REMOVE_EMPLOYER, employerId);

    }

    @Override
    public void editEmployer(Employer employer) {
        jdbcTemplate.update(SQL_UPDATE_EMPLOYER,
                employer.getCompanyName(),
                employer.getTier(),
                employer.getStatus(),
                employer.getCompanyPhone(),
                employer.getCompanyEmail(),
                employer.getCompanyAddress(),
                employer.getEmployerId());
    }

    @Override
    public Employer getEmployerById(int employerId) {
        try {

            return jdbcTemplate.queryForObject(SQL_SELECT_EMPLOYER, new EmployerMapper(), employerId);

        } catch (EmptyResultDataAccessException ex) {

            return null;
        }
    }

    @Override
    public Employer[] getAllEmployers() {
        List<Employer> empList = jdbcTemplate.query(SQL_SELECT_ALL_EMPLOYERS, new EmployerMapper());
        return empList.toArray(new Employer[0]);
    }

    private static final class EmployerMapper implements ParameterizedRowMapper<Employer> {

        public Employer mapRow(ResultSet rs, int rowNum) throws SQLException {
            Employer employer = new Employer();
            employer.setEmployerId(rs.getInt("employer_ID"));
            employer.setCompanyName(rs.getString("company_name"));
            employer.setTier(rs.getString("tier"));
            employer.setStatus(rs.getString("status"));
            employer.setCompanyPhone(rs.getString("company_phone"));
            employer.setCompanyEmail(rs.getString("company_email"));
            employer.setCompanyAddress(rs.getString("company_address"));
            return employer;
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Contact addContact(Contact newContact) {

        jdbcTemplate.update(SQL_INSERT_CONTACT, newContact.getEmployerId(), newContact.getFirstName(),
                newContact.getLastName(), newContact.getPhone(), newContact.getEmail(),
                newContact.getAddress(), newContact.getNote());
        newContact.setContactId(jdbcTemplate.queryForObject("select LAST_INSERT_ID()", Integer.class));
        return newContact;
    }

    @Override
    public void removeContact(int contactId) {

        jdbcTemplate.update(SQL_REMOVE_CONTACT, contactId);

    }
    
    public Contact getContactById(int contactId){
     try {

            return jdbcTemplate.queryForObject(SQL_GET_CONTACT_BY_ID, new ContactMapper(), contactId);

        } catch (EmptyResultDataAccessException ex) {

            return null;
        }
    }

    @Override
    public Contact[] getContactByEmployerId(int employerId) {
        List<Contact> ceList = jdbcTemplate.query(SQL_GET_CONTACTS, new ContactMapper(), employerId);
        return ceList.toArray(new Contact[0]);
    }

    public String[] getEmployerStatuses() {

        List<String> esList = jdbcTemplate.query(SQL_GET_EMPLOYER_STATUSES, new EmployerStatusMapper());
        return esList.toArray(new String[0]);

    }

    public String[] getEmployerTiers() {

        List<String> tList = jdbcTemplate.query(SQL_GET_TIERS, new TierMapper());
        return tList.toArray(new String[0]);

    }

    private static final class EmployerStatusMapper implements ParameterizedRowMapper<String> {

        public String mapRow(ResultSet rs, int rowNum) throws SQLException {
            return rs.getString("status");

        }

    }

    private static final class TierMapper implements ParameterizedRowMapper<String> {

        public String mapRow(ResultSet rs, int rowNum) throws SQLException {

            return rs.getString("name");

        }
    }

    private static final class ContactMapper implements ParameterizedRowMapper<Contact> {

        public Contact mapRow(ResultSet rs, int rowNum) throws SQLException {
            Contact contact = new Contact();
            contact.setContactId(rs.getInt("contact_ID"));
            contact.setEmployerId(rs.getInt("employer_ID"));
            contact.setFirstName(rs.getString("first_name"));
            contact.setLastName(rs.getString("last_name"));
            contact.setPhone(rs.getString("phone"));
            contact.setEmail(rs.getString("email"));
            contact.setAddress(rs.getString("address"));
            contact.setNote(rs.getString("note"));
            return contact;
        }
    }

}

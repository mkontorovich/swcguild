/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.swcmanager.dao;

import com.swcmanager.model.Cohort;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

/**
 *
 * @author apprentice
 */
public class CohortDaoDbImpl implements CohortDao {
    
    private static final String SQL_INSERT_COHORT = 
            "INSERT INTO cohorts (track,start_date) VALUES (?,?)";
    
    private static final String SQL_DELETE_COHORT = 
            "DELETE FROM cohorts WHERE cohort_id = ?";
    
    private static final String SQL_SELECT_COHORTS = 
            "SELECT * FROM cohorts";
    
    private static final String SQL_SELECT_COHORT =
            "SELECT * FROM cohorts WHERE cohort_id = ?";
    
    private static final String SQL_UPDATE_COHORT =
            "UPDATE cohorts SET track=?, start_date=? WHERE cohort_id=?";
    
    private JdbcTemplate jdbcTemplate;
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }        
            

    @Override
    public void deleteCohort(int cohortId) {
        jdbcTemplate.update(SQL_DELETE_COHORT, cohortId);
    }

    @Override
    public Cohort addCohort(Cohort cohort) {
        jdbcTemplate.update(SQL_INSERT_COHORT,
                cohort.getTrack(),cohort.getStartDate());
        
        cohort.setCohortId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));
        
        return cohort;
    }

    @Override
    public Cohort[] displayCohorts() {
        try {
        List<Cohort> cList = jdbcTemplate.query(SQL_SELECT_COHORTS , new CohortRowMapper());
        return cList.toArray(new Cohort[0]); 
        
        } catch(EmptyResultDataAccessException ex) {
            return null;
        }
        
    }
    
    
        @Override
    public Cohort getCohort(int cohortId) {
        try {

            return jdbcTemplate.queryForObject(SQL_SELECT_COHORT, new CohortRowMapper(), cohortId);

        } catch (EmptyResultDataAccessException ex) {

            return null;
        }
    }

    @Override
    public void updateCohort(Cohort cohort) {
        jdbcTemplate.update(SQL_UPDATE_COHORT, cohort.getTrack(), cohort.getStartDate(), cohort.getCohortId());
    }
    

    private static final class CohortRowMapper implements ParameterizedRowMapper<Cohort>{
        
        
        public Cohort mapRow(ResultSet rs, int rowNum) throws SQLException{
            
            Cohort cohort = new Cohort();
            cohort.setCohortId(rs.getInt("cohort_id") );
            cohort.setTrack(rs.getString("track") );
            cohort.setStartDate(rs.getDate("start_date") );
            return cohort;
            
        }
    }
    
   
    
}

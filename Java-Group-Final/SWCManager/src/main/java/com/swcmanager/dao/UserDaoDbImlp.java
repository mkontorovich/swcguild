/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.dao;

import com.swcmanager.model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class UserDaoDbImlp implements UserDao {
    
    private final String SQL_INSERT_USER
            = "INSERT INTO users (user_name, user_password, first_name, last_name, email)"
            + "VALUES (?, ?, ?, ?, ?)";
    
    private final String SQL_REMOVE_USER
            = "DELETE FROM users WHERE user_id=?";
    
    private final String SQL_UPDATE_USER
            = "UPDATE users SET user_name=?, user_password=?, first_name=?, "
            + "last_name=?, email=? where user_ID=?";
    
    private final String SQL_SELECT_USER
            = "select * from users where user_ID = ?";
    
    private final String SQL_GET_ALL_USERS
            = "select * FROM users";
    
    private final String SQL_GET_AUTH_BY_USER
            = "SELECT authority FROM authorities WHERE user_name=?";
    
    private final String SQL_ADD_AUTH
            = "INSERT INTO authorities (user_name, authority)"
            + " VALUES (?,?)";
    
    private final String SQL_REMOVE_AUTH
            = "DELETE FROM authorities WHERE user_name=? AND authority=?";
    
    private final String SQL_REMOVE_ALL_AUTH
            = "DELETE FROM authorities WHERE user_name=?";
    
    private JdbcTemplate jdbcTemplate;
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User addUser(User user) {
        jdbcTemplate.update(SQL_INSERT_USER, user.getUserName(), user.getUserPassword(), user.getFirstName(),
                user.getLastName(), user.getEmail());
        user.setUserId(jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class));
        
        return user;
    }
    
    @Override
    public User removeUser(int userId) {
        User user = getUser(userId);
        jdbcTemplate.update(SQL_REMOVE_USER, userId);
        
        return user;
    }
    
    @Override
    public void updateUser(User user) {
        jdbcTemplate.update(SQL_UPDATE_USER,
                user.getUserName(),
                user.getUserPassword(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getUserId());
    }
    
    @Override
    public User getUser(int userId) {
        try {
            User user = jdbcTemplate.queryForObject(SQL_SELECT_USER, new UserMapper(), userId);
            return user;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }
    
    @Override
    public User[] getAllUsers() {
        List<User> userList = jdbcTemplate.query(SQL_GET_ALL_USERS, new UserMapper());
        return userList.toArray(new User[0]);
    }
    
    @Override
    public String[] getAuth(String userName) {
        List<String> authList = jdbcTemplate.query(SQL_GET_AUTH_BY_USER, new AuthMapper(), userName);
        return authList.toArray(new String[0]);
    }
    
    @Override
    public void addAuth(String userName, String auth) {
        jdbcTemplate.update(SQL_ADD_AUTH, userName, auth);
    }
    
    @Override
    public void deleteAuth(String userName, String auth) {
        jdbcTemplate.update(SQL_REMOVE_AUTH, userName, auth);
    }
    
    @Override
    public void deleteAllAuth(String userName) {
        jdbcTemplate.update(SQL_REMOVE_ALL_AUTH, userName);
    }
    
    private final class UserMapper implements ParameterizedRowMapper<User> {
        
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setFirstName(rs.getString("first_name"));
            user.setLastName(rs.getString("last_name"));
            user.setEmail(rs.getString("email"));
            user.setUserName(rs.getString("user_name"));
            user.setUserPassword(rs.getString("user_password"));
            
            String[] auths = getAuth(user.getUserName());
            ArrayList<String> userAuths = new ArrayList<>();
            for (String auth : auths) {
                userAuths.add(auth);
            }
            user.setAuthorities(userAuths);
            
            return user;
        }
    }
    
    private final class AuthMapper implements ParameterizedRowMapper<String> {
        
        public String mapRow(ResultSet rs, int rowNum) throws SQLException {
            String auth = rs.getString("authority");
            return auth;
        }
    }
}

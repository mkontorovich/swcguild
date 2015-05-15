/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.swcmanager.dao;
import com.swcmanager.model.User;


/**
 *
 * @author apprentice
 */
public interface UserDao {
    
    public User addUser(User user); 
    
    public User removeUser(int userId);
    
    public  User getUser(int userId); 
    
    public User[] getAllUsers(); 
    
    public void updateUser(User user);
    
    public String[] getAuth(String userName);
    
    public void addAuth(String userName, String auth);
    
    public void deleteAuth(String userName, String auth);
    
    public void deleteAllAuth(String userName);
}
    
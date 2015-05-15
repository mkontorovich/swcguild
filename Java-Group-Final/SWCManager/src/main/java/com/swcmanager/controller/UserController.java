/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.controller;

import com.swcmanager.dao.UserDao;
import com.swcmanager.model.User;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author apprentice
 */
@Controller
public class UserController {

    private UserDao dao;

    @Inject
    public UserController(UserDao dao) {
        this.dao = dao;
    }

    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public String displayStudents(Map<String, Object> model) {
        model.put("users", dao.getAllUsers());
        User newUser = new User();
        model.put("newUser", newUser);

        return "displayUserList";
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public String addUser(Map<String, Object> model, HttpServletRequest req,
            HttpServletResponse res) throws ParseException {

        User newUser = new User();
        newUser.setFirstName(req.getParameter("firstName"));
        newUser.setLastName(req.getParameter("lastName"));
        newUser.setUserName(req.getParameter("userName"));
        newUser.setEmail(req.getParameter("email"));

        String clearPw = req.getParameter("password");
        String hashPw = new BCryptPasswordEncoder().encode(clearPw);

        newUser.setUserPassword(hashPw);
        dao.addUser(newUser);

        String[] auths = req.getParameterValues("auth");
        for (String auth : auths) {
            dao.addAuth(newUser.getUserName(), auth);
        }

        return "redirect:userList";
    }

    @RequestMapping(value = "/removeUser", method = RequestMethod.GET)
    public String deleteUser(@RequestParam("userId") String id,
            Map<String, Object> model) {

        User user = dao.getUser(Integer.parseInt(id));
        dao.deleteAllAuth(user.getUserName());
        dao.removeUser(Integer.parseInt(id));
        return "redirect:userList";
    }

    @RequestMapping(value = "/displayEditUser", method = RequestMethod.GET)
    public String editUser(Map<String, Object> model,
            @RequestParam("userId") String id) {

        User user = dao.getUser(Integer.parseInt(id));
        model.put("user", user);
        
        
        ArrayList<String> authorities = user.getAuthorities();
        Iterator<String> itr = authorities.iterator();
        
        while (itr.hasNext()) { 
            String current = itr.next();
            model.put(current, "checked");
        }
        
        return "updateUserForm";
    }

    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    public String editUser(@ModelAttribute("user") User user, Map<String, Object> model,
            HttpServletRequest req, HttpServletResponse res) {

        String clearPw = user.getUserPassword();
        String hashPw = new BCryptPasswordEncoder().encode(clearPw);
        user.setUserPassword(hashPw);

        dao.deleteAllAuth(user.getUserName());
        String[] auths = req.getParameterValues("auth");
        for (String auth : auths) {
            dao.addAuth(user.getUserName(), auth);
        }

        dao.updateUser(user);
        return "redirect:userList";
    }
}

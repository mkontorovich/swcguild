/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.swcmanager.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 *
 * @author daniel
 */
public class BCryptEncoder {

    public static void main(String[] args) {
        String hashedPw = new BCryptPasswordEncoder().encode("");
        System.out.println(hashedPw);
    }
}

package com.group05.controller;

import com.group05.userservice.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class PageController {
    @Autowired
    private UserService userService;

    //registration page
    @GetMapping("/register")
    public String register(){return "register";}

    //submission
    @PostMapping("/register")
    public String registerUser(@RequestParam String username, @RequestParam String password){
        userService.registerUser(username,password);
        return "redirect:/login";}

    //login page
    @GetMapping("/login")
    public String login() {return "login";}
}



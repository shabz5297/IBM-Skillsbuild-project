package com.group05.controller;

import com.group05.userservice.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import com.group05.model.User;


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

    // Home page after successful login
    @GetMapping("/home")
    public String home() {
        return "home";
    }

    //Profile Page
    @GetMapping("/profile/{id}")
    public String profile(@PathVariable Long id, Model model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "profile";
    }

    //Edit Profile Page
    @GetMapping("/profile/{id}/edit")
    public String editProfile(@PathVariable Long id, Model model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "edit-profile";
    }

    @PostMapping("/profile/{id}/edit")
    public String updateProfile(
            @PathVariable Long id,
            @RequestParam String displayName,
            @RequestParam String bio,
            @RequestParam String email
    ) {
        User user = userService.findById(id);

        user.setDisplayName(displayName);
        user.setBio(bio);
        user.setEmail(email);

        userService.save(user);

        return "redirect:/profile/" + id;
    }
}



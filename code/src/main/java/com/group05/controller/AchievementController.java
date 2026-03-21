package com.group05.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AchievementController {

    @GetMapping("/achievements")
    public String showAchievements() {
        return "achievements";
    }

}

package com.group05.controller;

import com.group05.repo.BadgeRepo;
import com.group05.model.Badge;
import com.group05.model.User;
import com.group05.repo.UserRepo;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class AchievementController {
    private final UserRepo userRepo;
    private final BadgeRepo badgeRepo;
    public AchievementController(UserRepo userRepo, BadgeRepo badgeRepo) {
        this.userRepo = userRepo;
        this.badgeRepo = badgeRepo;
    }
    private User getLoggedInUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }
        String username = authentication.getName();
        return userRepo.findByUsername(username);
    }

    @GetMapping("/achievements")
    public String achievements(Authentication authenticaton, Model model) {
        User user = userRepo.findByUsername(authenticaton.getName());
        if (user == null) {
            return "redirect:/login";
        }
        user=userRepo.findById(user.getId()).orElseThrow();
        model.addAttribute("user", user);
        return "achievements";
    }

}

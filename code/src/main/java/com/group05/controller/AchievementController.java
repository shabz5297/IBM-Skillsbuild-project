package com.group05.controller;

import com.group05.repo.BadgeRepo;
import com.group05.model.Badge;
import com.group05.model.User;
import com.group05.repo.UserRepo;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class AchievementController {
    private final UserRepo userRepo;
    private final BadgeRepo badgeRepo;
    public AchievementController(UserRepo userRepo, BadgeRepo badgeRepo) {
        this.userRepo = userRepo;
        this.badgeRepo = badgeRepo;
    }

    @GetMapping("/achievements")
    public String achievements(Authentication authenticaton, Model model, HttpServletRequest request) {
        User user = userRepo.findByUsername(authenticaton.getName());
        if (user == null) {
            return "redirect:/login";
        }
        String badgeCelebration = (String)request.getSession().getAttribute("badgeCelebration");
        if (badgeCelebration != null) {
            request.getSession().removeAttribute("badgeCelebration");
            model.addAttribute("badgeCelebration", badgeCelebration);
        }
        user=userRepo.findById(user.getId()).orElseThrow();
        model.addAttribute("user", user);
        model.addAttribute("allBadges", badgeRepo.findAll());
        return "achievements";
    }

}

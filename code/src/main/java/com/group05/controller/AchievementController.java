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
        if (authentication == null || !authentication.isAuthenticated()) return null;

        Object principal = authentication.getPrincipal();
        if (principal instanceof org.springframework.security.oauth2.core.user.OAuth2User oauthUser) {
            String providerId = String.valueOf(oauthUser.getAttributes().get("id"));
            return userRepo.findByProviderAndProviderId("GITHUB", providerId);
        }
        return userRepo.findByUsername(authentication.getName());
    }

    @GetMapping("/achievements")
    public String achievements(Authentication authenticaton, Model model) {
        User user = getLoggedInUser(authenticaton);
        if (user == null) {
            return "redirect:/login";
        }

        user = userRepo.findById(user.getId()).orElseThrow();
        model.addAttribute("user", user);
        return "achievements";
    }

}

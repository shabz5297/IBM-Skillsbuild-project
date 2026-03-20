package com.group05.controller;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import com.group05.userservice.CourseService;
import com.group05.userservice.LeaderboardService;
import com.group05.userservice.ReviewService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class LeaderboardController {
    private final LeaderboardService leaderboardService;
    private final UserRepo userRepo;

    public LeaderboardController(LeaderboardService leaderboardService, UserRepo userRepo) {
        this.leaderboardService = leaderboardService;
        this.userRepo = userRepo;
    }

    // Helper method to determine the currently logged-in user
    // Works for both OAuth logins (e.g. GitHub) and normal username/password logins
    private User getLoggedInUser(Authentication authentication) {

        // If there is no logged-in user, return null
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        Object principal = authentication.getPrincipal();

        // Handle OAuth login (e.g. GitHub login)
        if (principal instanceof org.springframework.security.oauth2.core.user.OAuth2User oauthUser) {

            // Get the provider ID from OAuth attributes
            String providerId = String.valueOf(oauthUser.getAttributes().get("id"));
            String provider = "GITHUB";

            // Find the user in the database using provider + provider ID
            return userRepo.findByProviderAndProviderId(provider, providerId);
        }

        // Handle normal login using username/password
        String username = authentication.getName();
        return userRepo.findByUsername(username);
    }

    @GetMapping("/leaderboard")
    public String leaderboard(Authentication authentication,
                              @RequestParam(value = "query", required = false) String query,
                              @RequestParam(value = "category", required = false) String category,
                              Model model) {

        User user = getLoggedInUser(authentication);

        model.addAttribute("leaderboardTop", leaderboardService.getTopStudents(10));
        model.addAttribute("userRank", user != null ? leaderboardService.getUserRank(user.getId()) : null);

        return "leaderboard";
    }

}

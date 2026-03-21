package com.group05.controller;

import com.group05.model.Goal;
// import com.group05.model.GoalStatus;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import com.group05.userservice.GoalService;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goals")
public class GoalController {

    private final GoalService goalService;
    private final UserRepo userRepo;

    public GoalController(GoalService goalService, UserRepo userRepo) {
        this.goalService = goalService;
        this.userRepo = userRepo;
    }

    // Goals page

    @GetMapping
    public String goalsPage(Authentication authentication, Model model) {
        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        List<Goal> allGoals    = goalService.getGoalsForUser(user);
        List<Goal> activeGoals = goalService.getActiveGoals(user);

        // Build a progress map: goalId -> courses completed so far
        Map<Long, Integer> progressMap = new HashMap<>();
        for (Goal goal : activeGoals) {
            progressMap.put(goal.getId(), goalService.getProgressForGoal(goal));
        }

        // Percentage for progress bars: goalId -> 0..100
        Map<Long, Integer> percentMap = new HashMap<>();
        for (Goal goal : activeGoals) {
            int pct = (int) Math.min(100,
                    (progressMap.get(goal.getId()) * 100.0 / goal.getTargetCount()));
            percentMap.put(goal.getId(), pct);
        }

        model.addAttribute("user", user);
        model.addAttribute("allGoals", allGoals);
        model.addAttribute("activeGoals", activeGoals);
        model.addAttribute("progressMap", progressMap);
        model.addAttribute("percentMap", percentMap);
        return "goals";
    }

    // Create goal

    @PostMapping("/create")
    public String createGoal(@RequestParam int targetCount,
                             @RequestParam int periodDays,
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            goalService.createGoal(user.getId(), targetCount, periodDays);
            redirectAttributes.addFlashAttribute("success",
                    "Goal created! Complete " + targetCount + " course(s) — good luck! 🎯");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/goals";
    }

    // Delete goal

    @PostMapping("/delete")
    public String deleteGoal(@RequestParam Long goalId,
                             Authentication authentication) {
        User user = getLoggedInUser(authentication);
        if (user != null) {
            goalService.deleteGoal(goalId, user.getId());
        }
        return "redirect:/goals";
    }

    // Helper

    private User getLoggedInUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) return null;

        Object principal = authentication.getPrincipal();
        if (principal instanceof OAuth2User oauthUser) {
            String providerId = String.valueOf(oauthUser.getAttributes().get("id"));
            return userRepo.findByProviderAndProviderId("GITHUB", providerId);
        }
        return userRepo.findByUsername(authentication.getName());
    }
}

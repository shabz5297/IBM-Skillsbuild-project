package com.group05.controller;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import com.group05.userservice.CourseService;
import com.group05.userservice.LeaderboardService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller // Marks this class as a Spring MVC controller that handles web requests
public class DashboardController {

    private final CourseService courseService;
    private final UserRepo userRepo;
    private final LeaderboardService leaderboardService;

    // Constructor injection: Spring automatically provides the required services/repositories
    public DashboardController(CourseService courseService, UserRepo userRepo, LeaderboardService leaderboardService) {
        this.courseService = courseService;
        this.userRepo = userRepo;
        this.leaderboardService = leaderboardService;
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

    // Loads the dashboard/home page
    @GetMapping("/home")
    public String dashboard(Authentication authentication,
                            @RequestParam(value = "query", required = false) String query,
                            @RequestParam(value = "category", required = false) String category,
                            Model model) {

        // Get the currently logged-in user
        User user = getLoggedInUser(authentication);

        // Get the user's saved courses
        List<Course> savedCourses = user != null
                ? courseService.getSavedCourses(user.getId())
                : List.of();

        // Create a set of saved course IDs for quick lookup in the JSP
        // Used to decide whether a star should be filled or empty
        Set<Long> savedCourseIds = user != null
                ? user.getSavedCourses().stream().map(Course::getId).collect(Collectors.toSet())
                : Set.of();

        // NEW: Completed course IDs + timestamps for UI
        Set<Long> completedCourseIds = user != null
                ? courseService.getCompletedCourseIds(user.getId())
                : Set.of();

        model.addAttribute("completionTimestamps",
                user != null ? courseService.getCompletionTimestamps(user.getId()) : java.util.Map.of()
        );

        model.addAttribute("completedCourseIds", completedCourseIds);

        // Send data to the JSP page
        model.addAttribute("savedCourseIds", savedCourseIds);
        model.addAttribute("savedCourses", savedCourses);
        model.addAttribute("courses", courseService.searchCourses(query, category));
        model.addAttribute("user", user);
        //fetches 10 top ranking users globally and the students current rank
        model.addAttribute("leaderboardTop", leaderboardService.getTopStudents(10));
        model.addAttribute("userRank", user != null ? leaderboardService.getUserRank(user.getId()) : null);


        // Return the JSP page name (home.jsp)
        return "home";
    }

    // Handles saving/favouriting a course
    @PostMapping("/saveCourse")
    public String saveCourse(@RequestParam Long courseId, Authentication authentication) {

        // Get logged-in user
        User user = getLoggedInUser(authentication);

        // Save course only if user exists
        if (user != null) {
            courseService.saveCourseForUser(user.getId(), courseId);
        }

        // Redirect back to dashboard so changes show
        return "redirect:/home";
    }

    // Handles removing a saved course
    @PostMapping("/removeCourse")
    public String removeCourse(@RequestParam("courseId") Long courseId,
                               Authentication authentication) {

        // Get logged-in user
        User user = getLoggedInUser(authentication);

        // Remove course only if user exists
        if (user != null) {
            courseService.removeCourseForUser(user.getId(), courseId);
        }

        // Redirect back to dashboard
        return "redirect:/home";
    }

    @PostMapping("/completeCourse")
    public String completeCourse(@RequestParam Long courseId, Authentication authentication) {
        User user = getLoggedInUser(authentication);
        if (user != null) {
            courseService.markCourseCompleted(user.getId(), courseId);
        }
        return "redirect:/home";
    }

    // Loads the profile page
    @GetMapping("/profile")
        public String profile(Authentication authentication, Model model) {
            User user = getLoggedInUser(authentication);
            model.addAttribute("user", user);
            return "profile";
        }
}
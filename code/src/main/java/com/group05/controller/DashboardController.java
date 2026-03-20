package com.group05.controller;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import com.group05.userservice.CourseService;
import com.group05.userservice.GoalService;
import com.group05.model.Goal;
import com.group05.userservice.LeaderboardService;
import com.group05.userservice.ReviewService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller // Marks this class as a Spring MVC controller that handles web requests
public class DashboardController {

    private final CourseService courseService;
    private final UserRepo userRepo;
    private final LeaderboardService leaderboardService;
    private final ReviewService reviewService;

    private final GoalService goalService;

    // Constructor injection: Spring automatically provides the required services/repositories
    public DashboardController(CourseService courseService, UserRepo userRepo, LeaderboardService leaderboardService, ReviewService reviewService, GoalService goalService) {
        this.courseService = courseService;
        this.userRepo = userRepo;
        this.leaderboardService = leaderboardService;
        this.reviewService = reviewService;

        this.goalService = goalService;
    }

    private String timeAgo(java.time.LocalDateTime dateTime) {
        java.time.Duration duration = java.time.Duration.between(dateTime, java.time.LocalDateTime.now());
        long seconds = duration.getSeconds();
        if (seconds < 60)           return "just now";
        if (seconds < 3600)         return (seconds / 60) + "m ago";
        if (seconds < 86400)        return (seconds / 3600) + "h ago";
        if (seconds < 604800)       return (seconds / 86400) + "d ago";
        if (seconds < 2592000)      return (seconds / 604800) + "w ago";
        return (seconds / 2592000) + "mo ago";
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
                            @RequestParam(value = "goalCompleted", required = false) String goalCompleted,
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

        List<Course> courses = courseService.searchCourses(query, category);

        Map<Long, String> completionTimestampsFormatted = new java.util.HashMap<>();
        if (user != null) {
            courseService.getCompletionTimestamps(user.getId()).forEach((courseId, dateTime) -> {
                completionTimestampsFormatted.put(courseId, timeAgo(dateTime));
            });
        }

        // ── Goal progress for dashboard widget ────────────────────
        List<Goal> activeGoals = user != null
                ? goalService.getActiveGoals(user) : List.of();

        Map<Long, Integer> goalProgressMap = new HashMap<>();
        Map<Long, Integer> goalPercentMap  = new HashMap<>();

        for (Goal goal : activeGoals) {
            int progress = goalService.getProgressForGoal(goal);
            int percent  = (int) Math.min(100,
                    (progress * 100.0 / goal.getTargetCount()));
            goalProgressMap.put(goal.getId(), progress);
            goalPercentMap.put(goal.getId(),  percent);
        }

        model.addAttribute("completionTimestamps", completionTimestampsFormatted);

        model.addAttribute("completedCourseIds", completedCourseIds);

        // Send data to the JSP page
        model.addAttribute("savedCourseIds", savedCourseIds);
        model.addAttribute("savedCourses", savedCourses);
        model.addAttribute("courses", courseService.searchCourses(query, category));
        model.addAttribute("user", user);
        //fetches 10 top ranking users globally and the students current rank
        model.addAttribute("leaderboardTop", leaderboardService.getTopStudents(10));
        model.addAttribute("userRank", user != null ? leaderboardService.getUserRank(user.getId()) : null);

        model.addAttribute("reviewSuccess", false);
        model.addAttribute("reviewError", null);

        model.addAttribute("reviewsByCourseId", courses.stream()
                .collect(Collectors.toMap(
                        Course::getId,
                        course -> reviewService.getReviewsForCourse(course.getId())
                )));

        model.addAttribute("averageRatings", courses.stream()
                .collect(Collectors.toMap(
                        Course::getId,
                        course -> reviewService.getAverageRating(course.getId())
                )));

        model.addAttribute("reviewableCourseIds", user != null
                ? courses.stream()
                .filter(course -> reviewService.canUserReview(user.getId(), course.getId()))
                .map(Course::getId)
                .collect(Collectors.toSet())
                : Set.of());

        model.addAttribute("reviewedCourseIds", user != null
                ? courses.stream()
                .filter(course -> reviewService.hasUserReviewed(user.getId(), course.getId()))
                .map(Course::getId)
                .collect(Collectors.toSet())
                : Set.of());

        // Goals widget data
        model.addAttribute("activeGoals",     activeGoals);
        model.addAttribute("goalProgressMap", goalProgressMap);
        model.addAttribute("goalPercentMap",  goalPercentMap);

        // Notification: a goal was just completed via course completion
        model.addAttribute("goalJustCompleted", "true".equals(goalCompleted));

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

            // Check whether any goal has now been fulfilled
            boolean goalAchieved = goalService.checkGoalsOnCompletion(user.getId());
            if (goalAchieved) {
                return "redirect:/home?goalCompleted=true";
            }

        }
        return "redirect:/home";
    }

    @PostMapping("/addReview")
    public String addReview(@RequestParam Long courseId,
                            @RequestParam int rating,
                            @RequestParam String comment,
                            Authentication authentication) {

        User user = getLoggedInUser(authentication);

        if (user == null) {
            return "redirect:/login";
        }

        try {
            reviewService.addReview(user.getId(), courseId, rating, comment);
            return "redirect:/home?reviewSuccess=true";
        } catch (IllegalArgumentException | IllegalStateException e) {
            return "redirect:/home?reviewError=true";
        }
    }

    // Loads the profile page
    @GetMapping("/profile")
        public String profile(Authentication authentication, Model model) {
            User user = getLoggedInUser(authentication);
            model.addAttribute("user", user);
            return "profile";
        }
}
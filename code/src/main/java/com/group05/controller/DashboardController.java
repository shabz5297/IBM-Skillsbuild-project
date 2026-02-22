package com.group05.controller;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import com.group05.userservice.CourseService;
import com.group05.userservice.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

@Controller
public class DashboardController {

    private final CourseService courseService;
    private final UserRepo userRepo;

    public DashboardController(CourseService courseService, UserRepo userRepo) {
        this.courseService = courseService;
        this.userRepo = userRepo;
    }

    @GetMapping("/home")
    public String dashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");

        // Always get latest saved courses from DB
        List<Course> savedCourses = user != null ? courseService.getSavedCourses(user.getId()) : List.of();
        model.addAttribute("savedCourses", savedCourses);

        // All courses
        List<Course> allCourses = courseService.getAllCourses();
        model.addAttribute("courses", allCourses);

        model.addAttribute("user", user);
        return "home";
    }

    @PostMapping("/saveCourse")
    public String saveCourse(@RequestParam("courseId") Long courseId, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null) {
            courseService.saveCourseForUser(sessionUser.getId(), courseId);

            // Refresh user from DB so savedCourses is up-to-date
            User updatedUser = userRepo.findById(sessionUser.getId()).orElse(sessionUser);
            session.setAttribute("user", updatedUser);
        }
        return "redirect:/home";
    }


    @GetMapping("/profile")
    public String profile(Model model) {
        return "profile";
    }
}

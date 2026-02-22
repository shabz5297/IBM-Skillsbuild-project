package com.group05.controller;

import com.group05.userservice.CourseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private final CourseService courseService;

    public DashboardController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/home")
    public String dashboard(Model model) {
        var courses = courseService.getAllCourses();
        System.out.println("COURSES: " + courses.size());
        model.addAttribute("courses", courses);
        return "home";
    }
}

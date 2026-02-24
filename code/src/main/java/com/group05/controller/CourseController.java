package com.group05.controller;

import com.group05.model.Course;
import com.group05.userservice.CourseService;
import org.antlr.v4.runtime.atn.ErrorInfo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/courses/search")
    public ResponseEntity<?> searchCourses(
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "category", required = false) String category
    ) {
        List<Course> results = courseService.searchCourses(query, category);

        if (results.isEmpty()) {
            return new ResponseEntity<>(
                    new ErrorInfo("No courses found matching your search."),
                    HttpStatus.NOT_FOUND
            );
        }

        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    public class ErrorInfo {
        private String message;

        public ErrorInfo(String message) {
            this.message = message;
        }

        public ErrorInfo() {}

        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }

}

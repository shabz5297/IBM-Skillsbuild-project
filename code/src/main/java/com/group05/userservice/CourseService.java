package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {

    private final CourseRepo courseRepository;
    private final UserRepo userRepository;

    public CourseService(CourseRepo courseRepository, UserRepo userRepository) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }

    // Get all courses from the database
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    // Get the courses saved by a specific user
    public List<Course> getSavedCourses(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        return user != null ? List.copyOf(user.getSavedCourses()) : List.of();
    }

    // Save a course for a user (adds to savedCourses)
    @Transactional
    public void saveCourseForUser(Long userId, Long courseId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        Course course = courseRepository.findById(courseId).orElseThrow(() -> new RuntimeException("Course not found"));

        // Check if already saved
        if (!user.getSavedCourses().contains(course)) {
            user.getSavedCourses().add(course);
            // Hibernate automatically persists the join table because of @Transactional
            userRepository.save(user);
        }
    }
}
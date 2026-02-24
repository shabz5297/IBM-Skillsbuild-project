package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service // Marks this as a service layer class (business logic)
public class CourseService {

    // Repositories used to access database tables
    private final CourseRepo courseRepository;
    private final UserRepo userRepository;

    // Constructor injection of repositories
    public CourseService(CourseRepo courseRepository, UserRepo userRepository) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }

    // Returns all courses stored in the database
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    // Returns courses saved by a specific user
    public List<Course> getSavedCourses(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        return user != null ? List.copyOf(user.getSavedCourses()) : List.of();
    }

    // Adds a course to a user's saved courses
    @Transactional // Ensures database updates happen in one transaction
    public void saveCourseForUser(Long userId, Long courseId) {

        // Fetch user and course from database
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        // Prevent duplicate saves
        if (!user.getSavedCourses().contains(course)) {
            user.getSavedCourses().add(course);

            // Save updates (join table updated automatically)
            userRepository.save(user);
        }

    }

    // Removes a saved course from a user
    @Transactional
    public void removeCourseForUser(Long userId, Long courseId) {

        // Fetch user and course
        User user = userRepository.findById(userId).orElseThrow();
        Course course = courseRepository.findById(courseId).orElseThrow();

        // Remove course from user's saved set
        user.getSavedCourses().remove(course);

        // Persist the change
        userRepository.save(user);
    }

    public List<Course> searchCourses(String query, String category) {
        // Check if a search keyword was provided (not null and not empty)
        boolean hasQuery = query != null && !query.trim().isEmpty();
        // Check if a category filter was provided (not null and not empty)
        boolean hasCategory = category != null && !category.trim().isEmpty();

        // Filter by category and search for keyword in title
        if (hasQuery && hasCategory) {
            return courseRepository.findByCategoryIgnoreCaseAndTitleContainingIgnoreCase(
                    category.trim(),
                    query.trim()
            );
        }

        // Search in title or description
        if (hasQuery) {
            String q = query.trim();
            return courseRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(q, q);
        }

        // Return all courses in that category
        if (hasCategory) {
            return courseRepository.findByCategoryIgnoreCase(category.trim());
        }

        return courseRepository.findAll();
    }
}


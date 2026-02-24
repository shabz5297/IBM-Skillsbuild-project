package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.CourseCompletion;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.CourseCompletionRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.List;

@Service // Marks this as a service layer class (business logic)
public class CourseService {

    // Repositories used to access database tables
    private final CourseRepo courseRepository;
    private final UserRepo userRepository;
    private final CourseCompletionRepo courseCompletionRepo;

    // Constructor injection of repositories
    public CourseService(CourseRepo courseRepository,
                         UserRepo userRepository,
                         CourseCompletionRepo courseCompletionRepo) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
        this.courseCompletionRepo = courseCompletionRepo;
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

    //Mark courses as completed for a user

    @Transactional
    public void markCourseCompleted(Long userId, Long courseId) {

        // Prevent duplicate completions
        if (courseCompletionRepo.existsByUser_IdAndCourse_Id(userId, courseId)) {
            return;
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        CourseCompletion completion = new CourseCompletion(user, course, LocalDateTime.now());
        courseCompletionRepo.save(completion);
    }

    public Set<Long> getCompletedCourseIds(Long userId) {
        return courseCompletionRepo.findAllByUser_Id(userId)
                .stream()
                .map(cc -> cc.getCourse().getId())
                .collect(Collectors.toSet());
    }

    public Map<Long, LocalDateTime> getCompletionTimestamps(Long userId) {
        Map<Long, LocalDateTime> map = new HashMap<>();
        for (CourseCompletion cc : courseCompletionRepo.findAllByUser_Id(userId)) {
            map.put(cc.getCourse().getId(), cc.getCompletedAt());
        }
        return map;
    }
}

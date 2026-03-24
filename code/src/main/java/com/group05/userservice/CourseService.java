package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.CourseCompletion;
import com.group05.model.User;
import com.group05.model.Badge;
import com.group05.repo.BadgeRepo;
import jakarta.servlet.http.HttpServletRequest;
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
    private final BadgeRepo badgeRepo;

    private static final int POINTS_PER_COMPLETION = 10;

    // Constructor injection of repositories
    public CourseService(CourseRepo courseRepository,
                         UserRepo userRepository,
                         CourseCompletionRepo courseCompletionRepo,
                         BadgeRepo badgeRepo) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
        this.courseCompletionRepo = courseCompletionRepo;
        this.badgeRepo = badgeRepo;
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
    public void markCourseCompleted(Long userId, Long courseId, HttpServletRequest request) {
        System.out.println("==== DEBUG START ====");
        System.out.println("Incoming userId: " + userId);
        System.out.println("Incoming courseId: " + courseId);

        boolean exists = userRepository.existsById(userId);
        System.out.println("User exists in DB: " + exists);
        userRepository.findAll().forEach(u ->
                System.out.println("DB USER -> id: " + u.getId() + ", username: " + u.getUsername()));
        System.out.println("==== DEBUG END ====");

        // Prevent duplicate completions
        if (courseCompletionRepo.existsByUser_IdAndCourse_Id(userId, courseId)) {
            return;
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found in DB (session stale)"));

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        CourseCompletion completion = new CourseCompletion(user, course, LocalDateTime.now());
        courseCompletionRepo.save(completion);

        user.addPoints(POINTS_PER_COMPLETION); // award points for leaderboard

        int completedCount = courseCompletionRepo.findAllByUser_Id(userId).size(); //counting the courses

        //Beginner Badge
        if (completedCount == 1) {
            Badge beginner = badgeRepo.findByName("Beginner");
            if (beginner != null && !user.getBadges().contains(beginner)) {
                user.getBadges().add(beginner);
                request.getSession().setAttribute("badgeCelebration", "Beginner");
            }
        }

        //Explorer Badge
        if (completedCount == 3){
            Badge explorer = badgeRepo.findByName("Explorer");
            if (explorer != null && !user.getBadges().contains(explorer)) {
                user.getBadges().add(explorer);
                request.getSession().setAttribute("badgeCelebration", "Explorer");
            }
        }
        userRepository.save(user); // saves everything
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



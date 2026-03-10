package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.Review;
import com.group05.model.User;
import com.group05.repo.CourseCompletionRepo;
import com.group05.repo.CourseRepo;
import com.group05.repo.ReviewRepo;
import com.group05.repo.UserRepo;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReviewService {

    private final ReviewRepo reviewRepo;
    private final CourseCompletionRepo courseCompletionRepo;
    private final UserRepo userRepo;
    private final CourseRepo courseRepo;

    public ReviewService( ReviewRepo reviewRepo,
                          CourseCompletionRepo courseCompletionRepo,
                          UserRepo userRepo,
                          CourseRepo courseRepo) {
        this.reviewRepo = reviewRepo;
        this.courseCompletionRepo = courseCompletionRepo;
        this.userRepo = userRepo;
        this.courseRepo = courseRepo;
    }

    public List<Review> getReviewsForCourse(Long courseId) {
        return reviewRepo.findByCourse_IdOrderByCreatedAtDesc(courseId);
    }

    public boolean hasUserReviewed(Long userId, Long courseId) {
        return reviewRepo.existsByUser_IdAndCourse_Id(userId, courseId);
    }

    public boolean canUserReview(Long userId, Long courseId) {
        return courseCompletionRepo.existsByUser_IdAndCourse_Id(userId, courseId)
                && !reviewRepo.existsByUser_IdAndCourse_Id(userId, courseId);
    }

    public double getAverageRating(Long courseId) {
        List<Review> reviews = reviewRepo.findByCourse_IdOrderByCreatedAtDesc(courseId);

        if (reviews.isEmpty()) {
            return 0.0;
        }

        return reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
    }

    public void addReview(Long userId, Long courseId, int rating, String comment) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5.");
        }

        if (comment == null || comment.trim().isEmpty()) {
            throw new IllegalArgumentException("Comment cannot be empty.");
        }

        boolean completed = courseCompletionRepo.existsByUser_IdAndCourse_Id(userId, courseId);
        if (!completed) {
            throw new IllegalStateException("You can only review a completed course.");
        }

        if (reviewRepo.existsByUser_IdAndCourse_Id(userId, courseId)) {
            throw new IllegalStateException("You have already reviewed this course.");
        }

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));

        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found."));

        Review review = new Review(user, course, rating, comment.trim(), LocalDateTime.now());
        reviewRepo.save(review);
    }

}

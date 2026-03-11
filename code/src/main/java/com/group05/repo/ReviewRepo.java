package com.group05.repo;

import com.group05.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepo extends JpaRepository<Review, Long> {

    List<Review> findByCourse_IdOrderByCreatedAtDesc(Long courseId);

    boolean existsByUser_IdAndCourse_Id(Long userId, Long courseId);
}

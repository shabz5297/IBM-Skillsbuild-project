package com.group05.repo;

import com.group05.model.CourseCompletion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseCompletionRepo extends JpaRepository<CourseCompletion, Long> {

    boolean existsByUser_IdAndCourse_Id(Long userId, Long courseId);

    List<CourseCompletion> findAllByUser_Id(Long userId);
}

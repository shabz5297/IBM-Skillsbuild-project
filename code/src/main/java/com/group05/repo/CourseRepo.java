package com.group05.repo;

import com.group05.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseRepo extends JpaRepository<Course, Long> {

    // keyword search in title or description
    List<Course> findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(String title, String description);

    // filter by category
    List<Course> findByCategoryIgnoreCase(String category);

    boolean existsByTitle(String title);

    // filter by category + keyword in title
    List<Course> findByCategoryIgnoreCaseAndTitleContainingIgnoreCase(String category, String title);
}


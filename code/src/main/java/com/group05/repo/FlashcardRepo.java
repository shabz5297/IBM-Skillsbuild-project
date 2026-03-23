package com.group05.repo;

import com.group05.model.Flashcard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FlashcardRepo extends JpaRepository<Flashcard, Long> {

    // All flashcards for a user on a specific course, newest first
    List<Flashcard> findByUser_IdAndCourse_IdOrderByCreatedAtDesc(Long userId, Long courseId);

    // All flashcards for a user across all courses
    List<Flashcard> findByUser_IdOrderByCreatedAtDesc(Long userId);

    // Ownership-safe lookup
    Optional<Flashcard> findByIdAndUser_Id(Long id, Long userId);

    // Count flashcards per course for dashboard badge
    int countByUser_IdAndCourse_Id(Long userId, Long courseId);
}
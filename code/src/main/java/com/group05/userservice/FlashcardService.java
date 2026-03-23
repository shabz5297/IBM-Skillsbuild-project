package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.Flashcard;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.FlashcardRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class FlashcardService {

    private final FlashcardRepo flashcardRepo;
    private final UserRepo      userRepo;
    private final CourseRepo    courseRepo;

    public FlashcardService(FlashcardRepo flashcardRepo, UserRepo userRepo, CourseRepo courseRepo) {
        this.flashcardRepo = flashcardRepo;
        this.userRepo      = userRepo;
        this.courseRepo    = courseRepo;
    }

    // ------------------------------------------------------------------ read

    public List<Flashcard> getFlashcardsForUserAndCourse(Long userId, Long courseId) {
        return flashcardRepo.findByUser_IdAndCourse_IdOrderByCreatedAtDesc(userId, courseId);
    }

    public List<Flashcard> getAllFlashcardsForUser(Long userId) {
        return flashcardRepo.findByUser_IdOrderByCreatedAtDesc(userId);
    }

    public Flashcard getFlashcardById(Long flashcardId, Long userId) {
        return flashcardRepo.findByIdAndUser_Id(flashcardId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Flashcard not found."));
    }

    public int countFlashcardsForCourse(Long userId, Long courseId) {
        return flashcardRepo.countByUser_IdAndCourse_Id(userId, courseId);
    }

    // ----------------------------------------------------------------- write

    @Transactional
    public Flashcard createFlashcard(Long userId, Long courseId, String question, String answer) {
        validateQuestion(question);
        validateAnswer(answer);

        User   user   = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));
        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found."));

        return flashcardRepo.save(new Flashcard(user, course, question.trim(), answer.trim()));
    }

    @Transactional
    public Flashcard updateFlashcard(Long flashcardId, Long userId, String question, String answer) {
        validateQuestion(question);
        validateAnswer(answer);

        Flashcard card = flashcardRepo.findByIdAndUser_Id(flashcardId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Flashcard not found."));

        card.setQuestion(question.trim());
        card.setAnswer(answer.trim());
        card.setUpdatedAt(LocalDateTime.now());
        return flashcardRepo.save(card);
    }

    @Transactional
    public void deleteFlashcard(Long flashcardId, Long userId) {
        Flashcard card = flashcardRepo.findByIdAndUser_Id(flashcardId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Flashcard not found."));
        flashcardRepo.delete(card);
    }

    // --------------------------------------------------------------- helpers

    private void validateQuestion(String question) {
        if (question == null || question.isBlank()) {
            throw new IllegalArgumentException("Question (front) cannot be empty.");
        }
        if (question.length() > 1000) {
            throw new IllegalArgumentException("Question must be 1000 characters or fewer.");
        }
    }

    private void validateAnswer(String answer) {
        if (answer == null || answer.isBlank()) {
            throw new IllegalArgumentException("Answer (back) cannot be empty.");
        }
        if (answer.length() > 2000) {
            throw new IllegalArgumentException("Answer must be 2000 characters or fewer.");
        }
    }
}
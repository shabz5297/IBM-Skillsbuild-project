package com.group05.repo;

import com.group05.model.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface NoteRepo extends JpaRepository<Note, Long> {

    // All notes for a user on a specific course, newest first
    List<Note> findByUser_IdAndCourse_IdOrderByUpdatedAtDesc(Long userId, Long courseId);

    // All notes for a user across all courses
    List<Note> findByUser_IdOrderByUpdatedAtDesc(Long userId);

    // Lookup a specific note belonging to a specific user (ownership check)
    Optional<Note> findByIdAndUser_Id(Long id, Long userId);
}
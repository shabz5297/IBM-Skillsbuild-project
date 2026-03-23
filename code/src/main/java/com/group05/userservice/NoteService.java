package com.group05.userservice;

import com.group05.model.Course;
import com.group05.model.Note;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.NoteRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class NoteService {

    private final NoteRepo    noteRepo;
    private final UserRepo    userRepo;
    private final CourseRepo  courseRepo;

    public NoteService(NoteRepo noteRepo, UserRepo userRepo, CourseRepo courseRepo) {
        this.noteRepo   = noteRepo;
        this.userRepo   = userRepo;
        this.courseRepo = courseRepo;
    }

    // ------------------------------------------------------------------ read

    public List<Note> getNotesForUserAndCourse(Long userId, Long courseId) {
        return noteRepo.findByUser_IdAndCourse_IdOrderByUpdatedAtDesc(userId, courseId);
    }

    public int countNotesForCourse(Long userId, Long courseId) {
        return noteRepo.findByUser_IdAndCourse_IdOrderByUpdatedAtDesc(userId, courseId).size();
    }

    public List<Note> getAllNotesForUser(Long userId) {
        return noteRepo.findByUser_IdOrderByUpdatedAtDesc(userId);
    }

    public Note getNoteById(Long noteId, Long userId) {
        return noteRepo.findByIdAndUser_Id(noteId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Note not found."));
    }

    // ----------------------------------------------------------------- write

    @Transactional
    public Note createNote(Long userId, Long courseId, String title, String content) {
        validateTitle(title);
        validateContent(content);

        User   user   = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));
        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found."));

        return noteRepo.save(new Note(user, course, title.trim(), content.trim()));
    }

    @Transactional
    public Note updateNote(Long noteId, Long userId, String title, String content) {
        validateTitle(title);
        validateContent(content);

        Note note = noteRepo.findByIdAndUser_Id(noteId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Note not found."));

        note.setTitle(title.trim());
        note.setContent(content.trim());
        note.setUpdatedAt(LocalDateTime.now());
        return noteRepo.save(note);
    }

    @Transactional
    public void deleteNote(Long noteId, Long userId) {
        Note note = noteRepo.findByIdAndUser_Id(noteId, userId)
                .orElseThrow(() -> new IllegalArgumentException("Note not found."));
        noteRepo.delete(note);
    }

    // --------------------------------------------------------------- helpers

    private void validateTitle(String title) {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("Title cannot be empty.");
        }
        if (title.length() > 200) {
            throw new IllegalArgumentException("Title must be 200 characters or fewer.");
        }
    }

    private void validateContent(String content) {
        if (content == null || content.isBlank()) {
            throw new IllegalArgumentException("Content cannot be empty.");
        }
        if (content.length() > 5000) {
            throw new IllegalArgumentException("Content must be 5000 characters or fewer.");
        }
    }
}
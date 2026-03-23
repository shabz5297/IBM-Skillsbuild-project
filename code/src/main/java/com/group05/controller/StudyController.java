package com.group05.controller;

import com.group05.model.Course;
import com.group05.model.Flashcard;
import com.group05.model.Note;
import com.group05.model.User;
import com.group05.repo.CourseRepo;
import com.group05.repo.UserRepo;
import com.group05.userservice.FlashcardService;
import com.group05.userservice.NoteService;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/study")
public class StudyController {

    private final NoteService      noteService;
    private final FlashcardService flashcardService;
    private final CourseRepo       courseRepo;
    private final UserRepo         userRepo;

    public StudyController(NoteService noteService,
                           FlashcardService flashcardService,
                           CourseRepo courseRepo,
                           UserRepo userRepo) {
        this.noteService      = noteService;
        this.flashcardService = flashcardService;
        this.courseRepo       = courseRepo;
        this.userRepo         = userRepo;
    }

    // ============================================================= AUTH HELPER

    private User getLoggedInUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) return null;

        Object principal = authentication.getPrincipal();
        if (principal instanceof OAuth2User oauthUser) {
            String providerId = String.valueOf(oauthUser.getAttributes().get("id"));
            return userRepo.findByProviderAndProviderId("GITHUB", providerId);
        }
        return userRepo.findByUsername(authentication.getName());
    }

    // ============================================================= STUDY ROOT FALLBACK

    /**
     * Bare /study with no courseId — redirect to home so the user can pick a course.
     * This prevents Spring from treating /study as a missing static resource (404).
     * GET /study
     */
    @GetMapping
    public String studyRoot(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) return "redirect:/login";
        return "redirect:/home";
    }

    // ============================================================= STUDY HUB (per course)

    /**
     * Main study page for a course — shows both notes and flashcards tabs.
     * GET /study/{courseId}
     */
    @GetMapping("/{courseId}")
    public String studyHub(@PathVariable Long courseId,
                           Authentication authentication,
                           Model model) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found"));

        List<Note>      notes      = noteService.getNotesForUserAndCourse(user.getId(), courseId);
        List<Flashcard> flashcards = flashcardService.getFlashcardsForUserAndCourse(user.getId(), courseId);

        model.addAttribute("user",       user);
        model.addAttribute("course",     course);
        model.addAttribute("notes",      notes);
        model.addAttribute("flashcards", flashcards);

        return "study";
    }

    // ============================================================= NOTES

    @PostMapping("/{courseId}/notes/create")
    public String createNote(@PathVariable Long courseId,
                             @RequestParam String title,
                             @RequestParam String content,
                             Authentication authentication,
                             RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            noteService.createNote(user.getId(), courseId, title, content);
            ra.addFlashAttribute("noteSuccess", "Note saved successfully!");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("noteError", e.getMessage());
        }
        return "redirect:/study/" + courseId;
    }

    @PostMapping("/{courseId}/notes/{noteId}/edit")
    public String editNote(@PathVariable Long courseId,
                           @PathVariable Long noteId,
                           @RequestParam String title,
                           @RequestParam String content,
                           Authentication authentication,
                           RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            noteService.updateNote(noteId, user.getId(), title, content);
            ra.addFlashAttribute("noteSuccess", "Note updated!");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("noteError", e.getMessage());
        }
        return "redirect:/study/" + courseId;
    }

    @PostMapping("/{courseId}/notes/{noteId}/delete")
    public String deleteNote(@PathVariable Long courseId,
                             @PathVariable Long noteId,
                             Authentication authentication,
                             RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            noteService.deleteNote(noteId, user.getId());
            ra.addFlashAttribute("noteSuccess", "Note deleted.");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("noteError", e.getMessage());
        }
        return "redirect:/study/" + courseId;
    }

    // ============================================================= FLASHCARDS

    @PostMapping("/{courseId}/flashcards/create")
    public String createFlashcard(@PathVariable Long courseId,
                                  @RequestParam String question,
                                  @RequestParam String answer,
                                  Authentication authentication,
                                  RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            flashcardService.createFlashcard(user.getId(), courseId, question, answer);
            ra.addFlashAttribute("flashcardSuccess", "Flashcard created!");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("flashcardError", e.getMessage());
        }
        return "redirect:/study/" + courseId + "#flashcards";
    }

    @PostMapping("/{courseId}/flashcards/{flashcardId}/edit")
    public String editFlashcard(@PathVariable Long courseId,
                                @PathVariable Long flashcardId,
                                @RequestParam String question,
                                @RequestParam String answer,
                                Authentication authentication,
                                RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            flashcardService.updateFlashcard(flashcardId, user.getId(), question, answer);
            ra.addFlashAttribute("flashcardSuccess", "Flashcard updated!");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("flashcardError", e.getMessage());
        }
        return "redirect:/study/" + courseId + "#flashcards";
    }

    @PostMapping("/{courseId}/flashcards/{flashcardId}/delete")
    public String deleteFlashcard(@PathVariable Long courseId,
                                  @PathVariable Long flashcardId,
                                  Authentication authentication,
                                  RedirectAttributes ra) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        try {
            flashcardService.deleteFlashcard(flashcardId, user.getId());
            ra.addFlashAttribute("flashcardSuccess", "Flashcard deleted.");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("flashcardError", e.getMessage());
        }
        return "redirect:/study/" + courseId + "#flashcards";
    }

    // ============================================================= STUDY MODE

    /**
     * Full-screen flashcard study/review mode.
     * GET /study/{courseId}/review
     */
    @GetMapping("/{courseId}/review")
    public String reviewMode(@PathVariable Long courseId,
                             Authentication authentication,
                             Model model) {

        User user = getLoggedInUser(authentication);
        if (user == null) return "redirect:/login";

        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found"));

        List<Flashcard> flashcards =
                flashcardService.getFlashcardsForUserAndCourse(user.getId(), courseId);

        model.addAttribute("user",       user);
        model.addAttribute("course",     course);
        model.addAttribute("flashcards", flashcards);

        return "study-review";
    }
}
package com.group05.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "flashcards")
public class Flashcard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    // "front" of the card — the question/term
    @Column(nullable = false, length = 1000)
    private String question;

    // "back" of the card — the answer/definition
    @Column(nullable = false, length = 2000)
    private String answer;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Flashcard() {}

    public Flashcard(User user, Course course, String question, String answer) {
        this.user      = user;
        this.course    = course;
        this.question  = question;
        this.answer    = answer;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Getters & setters
    public Long getId()                          { return id; }

    public User getUser()                        { return user; }
    public void setUser(User user)               { this.user = user; }

    public Course getCourse()                    { return course; }
    public void setCourse(Course course)         { this.course = course; }

    public String getQuestion()                  { return question; }
    public void setQuestion(String question)     { this.question = question; }

    public String getAnswer()                    { return answer; }
    public void setAnswer(String answer)         { this.answer = answer; }

    public LocalDateTime getCreatedAt()          { return createdAt; }
    public void setCreatedAt(LocalDateTime d)    { this.createdAt = d; }

    public LocalDateTime getUpdatedAt()          { return updatedAt; }
    public void setUpdatedAt(LocalDateTime d)    { this.updatedAt = d; }

    public String getUpdatedAtFormatted() {
        return updatedAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm"));
    }
}
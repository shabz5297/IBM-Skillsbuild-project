package com.group05.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "notes")
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(nullable = false, length = 5000)
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Note() {}

    public Note(User user, Course course, String title, String content) {
        this.user      = user;
        this.course    = course;
        this.title     = title;
        this.content   = content;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Getters & setters
    public Long getId()                          { return id; }

    public User getUser()                        { return user; }
    public void setUser(User user)               { this.user = user; }

    public Course getCourse()                    { return course; }
    public void setCourse(Course course)         { this.course = course; }

    public String getTitle()                     { return title; }
    public void setTitle(String title)           { this.title = title; }

    public String getContent()                   { return content; }
    public void setContent(String content)       { this.content = content; }

    public LocalDateTime getCreatedAt()          { return createdAt; }
    public void setCreatedAt(LocalDateTime d)    { this.createdAt = d; }

    public LocalDateTime getUpdatedAt()          { return updatedAt; }
    public void setUpdatedAt(LocalDateTime d)    { this.updatedAt = d; }

    public String getUpdatedAtFormatted() {
        return updatedAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm"));
    }

    public String getTimeAgo() {
        java.time.Duration dur = java.time.Duration.between(updatedAt, LocalDateTime.now());
        long s = dur.getSeconds();
        if (s < 60)      return "just now";
        if (s < 3600)    return (s / 60)   + "m ago";
        if (s < 86400)   return (s / 3600) + "h ago";
        if (s < 604800)  return (s / 86400)+ "d ago";
        return getUpdatedAtFormatted();
    }
}
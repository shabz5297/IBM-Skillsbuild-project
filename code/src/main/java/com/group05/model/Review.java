package com.group05.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "reviews",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "course_id"})
)
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(nullable = false)
    private int rating;

    @Column(nullable = false, length = 1000)
    private String comment;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    public Review() {}

    public Review(User user, Course course, int rating, String comment, LocalDateTime createdAt) {
        this.user = user;
        this.course = course;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public Long getId() { return id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getTimeAgo() {
        java.time.Duration duration = java.time.Duration.between(createdAt, java.time.LocalDateTime.now());
        long seconds = duration.getSeconds();
        if (seconds < 60)       return "just now";
        if (seconds < 3600)     return (seconds / 60) + "m ago";
        if (seconds < 86400)    return (seconds / 3600) + "h ago";
        if (seconds < 604800)   return (seconds / 86400) + "d ago";
        if (seconds < 2592000)  return (seconds / 604800) + "w ago";
        return (seconds / 2592000) + "mo ago";
    }
}

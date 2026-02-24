package com.group05.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "course_completions",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "course_id"})
)
public class CourseCompletion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(name = "completed_at", nullable = false)
    private LocalDateTime completedAt;

    public CourseCompletion() {}

    public CourseCompletion(User user, Course course, LocalDateTime completedAt) {
        this.user = user;
        this.course = course;
        this.completedAt = completedAt;
    }

    public Long getId() { return id; }

    public User getUser() { return user; }
    public Course getCourse() { return course; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
}

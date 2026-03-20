package com.group05.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "goals")
public class Goal {

    public enum GoalStatus {
        ACTIVE,
        COMPLETED,
        EXPIRED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private int targetCount;

    @Column(nullable = false)
    private int periodDays;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime deadline;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private GoalStatus status;

    @Column(nullable = false)
    private int pointsReward;

    public Goal() {}

    public Goal(User user, int targetCount, int periodDays) {
        this.user = user;
        this.targetCount = targetCount;
        this.periodDays = periodDays;
        this.createdAt = LocalDateTime.now();
        this.deadline = this.createdAt.plusDays(periodDays);
        this.status = GoalStatus.ACTIVE;
        this.pointsReward = calculateReward(periodDays, targetCount);
    }

    private int calculateReward(int days, int count) {
        int base = count * 15;
        if (days == 1)  return base;
        if (days == 7)  return base + 25;
        return base + 60;
    }

    public String getPeriodLabel() {
        if (periodDays == 1)  return "Daily";
        if (periodDays == 7)  return "Weekly";
        if (periodDays == 30) return "Monthly";
        return periodDays + "-Day";
    }

    public Long getId()                       { return id; }
    public User getUser()                     { return user; }
    public void setUser(User user)            { this.user = user; }
    public int getTargetCount()               { return targetCount; }
    public void setTargetCount(int t)         { this.targetCount = t; }
    public int getPeriodDays()                { return periodDays; }
    public void setPeriodDays(int p)          { this.periodDays = p; }
    public LocalDateTime getCreatedAt()       { return createdAt; }
    public void setCreatedAt(LocalDateTime d) { this.createdAt = d; }
    public LocalDateTime getDeadline()        { return deadline; }
    public void setDeadline(LocalDateTime d)  { this.deadline = d; }
    public String getDeadlineFormatted() {
        return deadline.format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm"));
    }
    public GoalStatus getStatus()             { return status; }
    public void setStatus(GoalStatus s)       { this.status = s; }
    public int getPointsReward()              { return pointsReward; }
    public void setPointsReward(int p)        { this.pointsReward = p; }
}
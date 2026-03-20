package com.group05.userservice;

import com.group05.model.Badge;
import com.group05.model.Goal;
import com.group05.model.User;
import com.group05.repo.BadgeRepo;
import com.group05.repo.CourseCompletionRepo;
import com.group05.repo.GoalRepo;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class GoalService {

    private final GoalRepo goalRepo;
    private final UserRepo userRepo;
    private final CourseCompletionRepo courseCompletionRepo;
    private final BadgeRepo badgeRepo;

    public GoalService(GoalRepo goalRepo,
                       UserRepo userRepo,
                       CourseCompletionRepo courseCompletionRepo,
                       BadgeRepo badgeRepo) {
        this.goalRepo = goalRepo;
        this.userRepo = userRepo;
        this.courseCompletionRepo = courseCompletionRepo;
        this.badgeRepo = badgeRepo;
    }

    public List<Goal> getGoalsForUser(User user) {
        return goalRepo.findByUserOrderByCreatedAtDesc(user);
    }

    public List<Goal> getActiveGoals(User user) {
        expireOverdueGoals(user);
        return goalRepo.findByUserAndStatus(user, Goal.GoalStatus.ACTIVE);
    }

    public int getProgressForGoal(Goal goal) {
        return countCompletionsInPeriod(goal.getUser().getId(),
                goal.getCreatedAt(), goal.getDeadline());
    }

    @Transactional
    public void createGoal(Long userId, int targetCount, int periodDays) {
        if (targetCount < 1 || targetCount > 20) {
            throw new IllegalArgumentException("Target must be between 1 and 20 courses.");
        }
        if (periodDays != 1 && periodDays != 7 && periodDays != 30) {
            throw new IllegalArgumentException("Period must be 1, 7, or 30 days.");
        }

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));

        long activeCount = goalRepo.findByUserAndStatus(user, Goal.GoalStatus.ACTIVE).size();
        if (activeCount >= 3) {
            throw new IllegalStateException("You can have at most 3 active goals at a time.");
        }

        goalRepo.save(new Goal(user, targetCount, periodDays));
    }

    @Transactional
    public boolean checkGoalsOnCompletion(Long userId) {
        User user = userRepo.findById(userId).orElse(null);
        if (user == null) return false;

        expireOverdueGoals(user);

        List<Goal> active = goalRepo.findByUserAndStatus(user, Goal.GoalStatus.ACTIVE);
        boolean anyCompleted = false;

        for (Goal goal : active) {
            int progress = countCompletionsInPeriod(userId,
                    goal.getCreatedAt(), goal.getDeadline());

            if (progress >= goal.getTargetCount()) {
                goal.setStatus(Goal.GoalStatus.COMPLETED);
                goalRepo.save(goal);

                user.addPoints(goal.getPointsReward());

                Badge badge = new Badge(
                        goal.getPeriodLabel() + " Goal Achiever 🏆",
                        "Completed " + goal.getTargetCount() + " courses in a "
                                + goal.getPeriodLabel().toLowerCase() + " goal"
                );
                badge = badgeRepo.save(badge);
                user.getBadges().add(badge);
                userRepo.save(user);
                anyCompleted = true;
            }
        }
        return anyCompleted;
    }

    @Transactional
    public void deleteGoal(Long goalId, Long userId) {
        goalRepo.findById(goalId).ifPresent(goal -> {
            if (goal.getUser().getId().equals(userId)
                    && goal.getStatus() == Goal.GoalStatus.ACTIVE) {
                goalRepo.delete(goal);
            }
        });
    }

    private void expireOverdueGoals(User user) {
        LocalDateTime now = LocalDateTime.now();
        List<Goal> active = goalRepo.findByUserAndStatus(user, Goal.GoalStatus.ACTIVE);
        for (Goal goal : active) {
            if (goal.getDeadline().isBefore(now)) {
                goal.setStatus(Goal.GoalStatus.EXPIRED);
                goalRepo.save(goal);
            }
        }
    }

    private int countCompletionsInPeriod(Long userId, LocalDateTime from, LocalDateTime to) {
        return (int) courseCompletionRepo.findAllByUser_Id(userId).stream()
                .filter(cc -> !cc.getCompletedAt().isBefore(from)
                        && !cc.getCompletedAt().isAfter(to))
                .count();
    }
}
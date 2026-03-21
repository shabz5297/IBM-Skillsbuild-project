package com.group05.repo;

import com.group05.model.Goal;
import com.group05.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoalRepo extends JpaRepository<Goal, Long> {

    List<Goal> findByUserOrderByCreatedAtDesc(User user);

    List<Goal> findByUserAndStatus(User user, Goal.GoalStatus status);
}
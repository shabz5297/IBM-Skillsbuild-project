package com.group05.userservice;

import com.group05.model.User;
import com.group05.repo.UserRepo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

// leaderboard logic, showing users current rank and top users
@Service
public class LeaderboardService {

    private final UserRepo userRepo;

    public LeaderboardService(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    public List<User> getTopStudents(int limit) {
        List<User> ordered = userRepo.findAllByOrderByPointsDescLevelDescUsernameAsc();
        return ordered.size() <= limit ? ordered : ordered.subList(0, limit);
    }

    public Integer getUserRank(Long userId) {
        List<User> ordered = userRepo.findAllByOrderByPointsDescLevelDescUsernameAsc();
        for (int i = 0; i < ordered.size(); i++) {
            if (ordered.get(i).getId() != null && ordered.get(i).getId().equals(userId)) {
                return i + 1;
            }
        }
        return null;
    }


}

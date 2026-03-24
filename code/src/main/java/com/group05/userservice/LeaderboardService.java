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

    public List<User> getFriendsLeaderboard(Long userId) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Get user's friends and include the user themselves
        Set<User> friendsAndUser = new java.util.HashSet<>(user.getFriends());
        friendsAndUser.add(user);

        // Sort by points (desc), then level (desc), then username (asc)
        // Sort by points (desc), then level (desc), then username (asc)
        return friendsAndUser.stream()
                .sorted((a, b) -> {
                    if (b.getPoints() != a.getPoints()) {
                        return Integer.compare(b.getPoints(), a.getPoints());
                    }
                    if (b.getLevel() != a.getLevel()) {
                        return Integer.compare(b.getLevel(), a.getLevel());
                    }
                    return a.getUsername().compareTo(b.getUsername());
                })
                .collect(java.util.stream.Collectors.toList());
    }

    public Integer getFriendsRank(Long userId, Long currentUserId) {
        List<User> friendsLeaderboard = getFriendsLeaderboard(currentUserId);
        for (int i = 0; i < friendsLeaderboard.size(); i++) {
            if (friendsLeaderboard.get(i).getId().equals(userId)) {
                return i + 1;
            }
        }
        return null;
    }
}

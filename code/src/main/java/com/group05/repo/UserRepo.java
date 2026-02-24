package com.group05.repo;

import com.group05.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepo extends JpaRepository <User, Long> {

    User findByUsername(String username);
    // extend repo to find users by provider id
    User findByProviderAndProviderId(String provider, String providerId);
    User findByEmail(String email);

    // implementing leaderboard ordering
    List<User> findAllByOrderByPointsDescLevelDescUsernameAsc();
}

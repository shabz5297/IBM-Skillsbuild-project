package com.group05.repo;

import com.group05.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface UserRepo extends JpaRepository <User, Long> {

    // extend repo to find users by provider id
    User findByProviderAndProviderId(String provider, String providerId);
    User findByEmail(String email);

    // implementing leaderboard ordering
    List<User> findAllByOrderByPointsDescLevelDescUsernameAsc();

    User findByUsername(String username);


    //added optional value for friends tab to not interfere with the regular find by user method
    Optional<User> findOptionalByUsername(String username);
}

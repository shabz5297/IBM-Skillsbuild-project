package com.group05.userservice;

import com.group05.model.User;
import com.group05.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import java.util.Set;

//friends tab
@Service
public class FriendService {

    private final UserRepo userRepo;

    public FriendService(UserRepo userRepo) {this.userRepo = userRepo;}

    // get friend list
    public Set<User> getFriend(String username) {
        User user = userRepo.findOptionalByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getFriends();
    }

    @Transactional
    //nethod to add friend with exceptions caught
    public void addFriend(String currentUsername, String friendUsername) {
        User user = userRepo.findOptionalByUsername(currentUsername)
                .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

        User friend = userRepo.findOptionalByUsername(friendUsername)
                .orElseThrow(() -> new IllegalArgumentException("Friend username not found"));

        if (user.getUsername().equals(friend.getUsername())) {
            throw new IllegalArgumentException("You cannot add yourself");
        }
        if (user.getFriends().contains(friend)) {
            throw new IllegalArgumentException("Your are already friends");
        }


        user.getFriends().add(friend);
        friend.getFriends().add(user);

        userRepo.save(user);
        userRepo.save(friend);

    }

    //method to remove friend
    @Transactional
        public void removeFriend(String currentUsername, String friendUsername) {
            User user = userRepo.findOptionalByUsername(currentUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

            User friend = userRepo.findOptionalByUsername(friendUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Friend username not found"));

            user.getFriends().remove(friend);
            friend.getFriends().remove(friend);

            userRepo.save(user);
            userRepo.save(friend);

        }

    }


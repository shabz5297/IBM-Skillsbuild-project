package com.group05.userservice;

import com.group05.model.FriendRequest;
import com.group05.model.FriendRequestStatus;
import com.group05.model.User;
import com.group05.model.Badge;
import com.group05.repo.BadgeRepo;
import com.group05.repo.FriendRequestRepo;
import com.group05.repo.UserRepo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.ArrayList;

@Service
public class FriendService {

    private final UserRepo userRepo;
    private final FriendRequestRepo friendRequestRepo;
    private final BadgeRepo badgeRepo;

    public FriendService(UserRepo userRepo, FriendRequestRepo friendRequestRepo, BadgeRepo badgeRepo) {
        this.userRepo = userRepo;
        this.friendRequestRepo = friendRequestRepo;
        this.badgeRepo = badgeRepo;
    }

    public Set<User> getFriends(String username) {
        User user = userRepo.findOptionalByUsername(username)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        return user.getFriends();
    }

    public List<FriendRequest> getPendingRequests(String username) {
        User user = userRepo.findOptionalByUsername(username)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        return friendRequestRepo.findByReceiverAndStatus(user, FriendRequestStatus.PENDING);
    }

    @Transactional
    public void sendFriendRequest(String currentUsername, String friendUsername) {
        User sender = userRepo.findOptionalByUsername(currentUsername)
                .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

        User receiver = userRepo.findOptionalByUsername(friendUsername)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        if(sender.getId() == null || receiver.getId() == null) {
            throw new RuntimeException("User ID is null - user not persisted in database");
        }
        System.out.println("SENDER -" + sender.getUsername() + " ID=" + sender.getId());
        System.out.println("RECEIVER -" + receiver.getUsername() + " ID=" + receiver.getId());

        if (sender.getUsername().equals(receiver.getUsername())) {
            throw new IllegalArgumentException("You cannot add yourself");
        }

        if (sender.getFriends().contains(receiver)) {
            throw new IllegalArgumentException("You are already friends");
        }

        boolean requestAlreadyExists =
                friendRequestRepo.existsBySenderAndReceiverAndStatus(sender, receiver, FriendRequestStatus.PENDING)
                        || friendRequestRepo.existsByReceiverAndSenderAndStatus(sender, receiver, FriendRequestStatus.PENDING);

        if (requestAlreadyExists) {
            throw new IllegalArgumentException("A friend request is already pending");
        }

        FriendRequest request = new FriendRequest(sender, receiver);
        friendRequestRepo.save(request);
    }

    @Transactional
    public void acceptFriendRequest(Long requestId, String currentUsername, HttpServletRequest request) {

        User receiver = userRepo.findOptionalByUsername(currentUsername)
                .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

        FriendRequest friendRequest = friendRequestRepo.findByIdAndReceiver(requestId, receiver)
                .orElseThrow(() -> new IllegalArgumentException("Friend request not found"));

        if (friendRequest.getStatus() != FriendRequestStatus.PENDING) {
            throw new IllegalArgumentException("This request is no longer pending");
        }

        User sender = friendRequest.getSender();

        receiver.getFriends().add(sender);
        sender.getFriends().add(receiver);

        List<String> badgeCelebrations = new ArrayList<>();
        Badge socializer = badgeRepo.findByName("Socializer");

        if (receiver.getFriends().size() == 1 &&
                socializer != null &&
                !receiver.getBadges().contains(socializer)) {

            receiver.getBadges().add(socializer);
            badgeCelebrations.add("Socializer");
        }

        if (sender.getFriends().size() == 1 &&
                socializer != null &&
                !sender.getBadges().contains(socializer)) {

            sender.getBadges().add(socializer);
            badgeCelebrations.add("Socializer");
        }

        if (!badgeCelebrations.isEmpty()) {
            request.getSession().setAttribute("badgeCelebrations", badgeCelebrations);
        }

        friendRequest.setStatus(FriendRequestStatus.ACCEPTED);
    }
    @Transactional
    public void declineFriendRequest(Long requestId, String currentUsername) {
        User receiver = userRepo.findOptionalByUsername(currentUsername)
                .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

        FriendRequest request = friendRequestRepo.findByIdAndReceiver(requestId, receiver)
                .orElseThrow(() -> new IllegalArgumentException("Friend request not found"));

        if (request.getStatus() != FriendRequestStatus.PENDING) {
            throw new IllegalArgumentException("This request is no longer pending");
        }

        request.setStatus(FriendRequestStatus.DENIED);
        friendRequestRepo.save(request);
    }

    @Transactional
    public void removeFriend(String currentUsername, String friendUsername) {
        User user = userRepo.findOptionalByUsername(currentUsername)
                .orElseThrow(() -> new IllegalArgumentException("Current user not found"));

        User friend = userRepo.findOptionalByUsername(friendUsername)
                .orElseThrow(() -> new IllegalArgumentException("Friend not found"));

        if (!user.getFriends().contains(friend)) {
            throw new IllegalArgumentException("You are not friends");
        }

        user.getFriends().remove(friend);
        friend.getFriends().remove(user);

        userRepo.save(user);
        userRepo.save(friend);
    }
}
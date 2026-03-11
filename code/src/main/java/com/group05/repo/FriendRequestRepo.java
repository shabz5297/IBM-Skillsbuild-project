package com.group05.repo;

import com.group05.model.FriendRequest;
import com.group05.model.FriendRequestStatus;
import com.group05.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FriendRequestRepo extends JpaRepository<FriendRequest, Long> {

    List<FriendRequest> findByReceiverAndStatus(User receiver, FriendRequestStatus status);

    List<FriendRequest> findBySenderAndStatus(User sender, FriendRequestStatus status);

    boolean existsBySenderAndReceiverAndStatus(User sender, User receiver, FriendRequestStatus status);

    boolean existsByReceiverAndSenderAndStatus(User receiver, User sender, FriendRequestStatus status);

    Optional<FriendRequest> findByIdAndReceiver(Long id, User receiver);
}
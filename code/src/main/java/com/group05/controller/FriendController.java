package com.group05.controller;

import com.group05.userservice.FriendService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/friends")
public class FriendController {

    private final FriendService friendService;

    public FriendController(FriendService friendService) {
        this.friendService = friendService;
    }

    @GetMapping
    public String friendPage(Authentication auth, Model model) {
        String username = auth.getName();
        model.addAttribute("friends", friendService.getFriends(username));
        model.addAttribute("pendingRequests", friendService.getPendingRequests(username));
        return "friends";
    }

    @PostMapping("/request")
    public String sendRequest(@RequestParam String username,
                              Authentication auth,
                              RedirectAttributes redirectAttributes) {
        try {
            friendService.sendFriendRequest(auth.getName(), username);
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/friends";
    }

    @PostMapping("/accept")
    public String acceptRequest(@RequestParam Long requestId,
                                Authentication auth,
                                RedirectAttributes redirectAttributes, HttpServletRequest request) {
        try {
            friendService.acceptFriendRequest(requestId, auth.getName(), request);
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/friends";
    }

    @PostMapping("/decline")
    public String declineRequest(@RequestParam Long requestId,
                                 Authentication auth,
                                 RedirectAttributes redirectAttributes) {
        try {
            friendService.declineFriendRequest(requestId, auth.getName());
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/friends";
    }

    @PostMapping("/remove")
    public String removeFriend(@RequestParam String username,
                               Authentication auth) {
        friendService.removeFriend(auth.getName(), username);
        return "redirect:/friends";
    }
}
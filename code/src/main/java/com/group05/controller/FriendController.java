package com.group05.controller;

import com.group05.userservice.FriendService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profile/friends")

public class FriendController {

        private final FriendService friendService;

        public FriendController(FriendService friendService) {
            this.friendService = friendService;
        }

        @GetMapping
        public String friendPage(Authentication auth, Model model) {
            String username = auth.getName();
            model.addAttribute("friends", friendService.getFriend(username));
            return "friends";
        }

        @PostMapping("/add")
        public String addFriend(@RequestParam String username, Authentication auth,
                                RedirectAttributes redirectAttributes) {
            try {
                friendService.addFriend(auth.getName(), username);
            } catch (IllegalArgumentException e) {
                redirectAttributes.addAttribute("error", e.getMessage());
                redirectAttributes.addAttribute("friends", friendService.getFriend(auth.getName()));
                return "friends";
            }
            return "redirect:/profile/friends";
        }

        @PostMapping("/remove")
        public String removeFriend(@RequestParam String username, Authentication auth,
                                   RedirectAttributes redirectAttributes) {
            friendService.removeFriend(auth.getName(), username);
            return "redirect:/profile/friends";
        }
    }


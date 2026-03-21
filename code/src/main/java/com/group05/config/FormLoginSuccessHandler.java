package com.group05.config;

import com.group05.model.Badge;
import com.group05.model.User;
import com.group05.repo.BadgeRepo;
import com.group05.repo.UserRepo;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDate;
import java.util.stream.*;

@Component
public class FormLoginSuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepo userRepo;
    private final BadgeRepo badgeRepo;

    public FormLoginSuccessHandler(UserRepo userRepo, BadgeRepo badgeRepo) {
        this.userRepo = userRepo;
        this.badgeRepo = badgeRepo;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        String username = authentication.getName();
        System.out.println("LOGIN DEBUG STARTS");
        System.out.println("Username from auth: " + username);

        User user = userRepo.findByUsername(username);
        System.out.println("User found in DB: " + user);

        // 🔥 CREATE USER IF NOT EXISTS
        if (user == null) {
            System.out.println("User not found, creating new one");
            user = new User();
            user.setUsername(username);
            user.setProvider("LOCAL");
            user.setStreak(1);
            user.setLastLogin(LocalDate.now());
            System.out.println("BEFORE SAVE");
            userRepo.save(user);
            System.out.println("AFTER SAVE, ID = " + user.getId());

            // Give First Login badge
            Badge firstLogin = badgeRepo.findByName("First Login");
            if (firstLogin != null) {
                user.getBadges().add(firstLogin);
                request.getSession().setAttribute("badgeCelebration", "First Login");
            }

            userRepo.save(user);

            request.getSession().setAttribute("streakCelebration", true);

            System.out.println("✅ NEW USER CREATED: " + username);
        } else {

            LocalDate today = LocalDate.now();
            LocalDate lastLogin = user.getLastLogin();

            boolean hasFirstLoginBadge = user.getBadges().stream()
                    .anyMatch(b -> b.getName().equals("First Login"));

            if (!hasFirstLoginBadge) {
                Badge firstLogin = badgeRepo.findByName("First Login");

                if (firstLogin != null) {
                    user.getBadges().add(firstLogin);
                    request.getSession().setAttribute("badgeCelebration", "First Login");
                    System.out.println("First Login badge assigned!");
                }
            }

            if (lastLogin != null) {

                if (lastLogin.plusDays(1).equals(today)) {
                    user.setStreak(user.getStreak() + 1);
                    request.getSession().setAttribute("streakCelebration", true);
                } else if (!lastLogin.equals(today)) {
                    user.setStreak(1);
                    request.getSession().setAttribute("streakCelebration", true);
                }

            } else {
                user.setStreak(1);
                request.getSession().setAttribute("streakCelebration", true);
            }

            user.setLastLogin(today);

            userRepo.save(user);

            System.out.println("LOGIN DEBUG ENDS");
        }

        response.sendRedirect("/home");
    }
}
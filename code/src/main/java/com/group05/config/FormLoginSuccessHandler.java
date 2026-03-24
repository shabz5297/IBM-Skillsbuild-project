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
        User user = userRepo.findByUsername(username);

        LocalDate today = LocalDate.now();

        // =========================
        // 🆕 NEW USER
        // =========================
        if (user == null) {
            user = new User();
            user.setUsername(username);
            user.setProvider("LOCAL");
            user.setStreak(1);
            user.setLastLogin(today);

            // ✅ SAVE FIRST (IMPORTANT)
            user = userRepo.save(user);

            // ✅ THEN assign badge
            Badge firstLogin = badgeRepo.findByName("First Login");
            if (firstLogin != null) {
                user.getBadges().add(firstLogin);
                request.getSession().setAttribute("badgeCelebration", "First Login");
            }

            // ✅ SAVE AGAIN AFTER RELATIONSHIP CHANGE
            userRepo.save(user);

            request.getSession().setAttribute("streakCelebration", true);
        }

        // =========================
        // 🔁 EXISTING USER
        // =========================
        else {
            LocalDate lastLogin = user.getLastLogin();

            // ✅ FIRST LOGIN BADGE CHECK
            boolean hasFirstLogin = user.getBadges().stream()
                    .anyMatch(b -> b.getName().equals("First Login"));

            if (!hasFirstLogin) {
                Badge firstLogin = badgeRepo.findByName("First Login");
                if (firstLogin != null) {
                    user.getBadges().add(firstLogin);
                    request.getSession().setAttribute("badgeCelebration", "First Login");
                }
            }

            // ✅ STREAK LOGIC
            if (lastLogin != null) {
                if (lastLogin.plusDays(1).equals(today)) {
                    user.setStreak(user.getStreak() + 1);
                } else if (!lastLogin.equals(today)) {
                    user.setStreak(1);
                }
            } else {
                user.setStreak(1);
            }

            request.getSession().setAttribute("streakCelebration", true);
            user.setLastLogin(today);

            userRepo.save(user);
        }

        response.sendRedirect("/home");
    }
}
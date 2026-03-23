package com.group05.config;

import com.group05.model.Badge;
import com.group05.model.User;
import com.group05.repo.BadgeRepo;
import com.group05.repo.UserRepo;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;
import java.time.LocalDate;

@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepo userRepo;
    private final BadgeRepo badgeRepo;

    public OAuth2LoginSuccessHandler(UserRepo userRepo, BadgeRepo badgeRepo) {
        this.userRepo = userRepo;
        this.badgeRepo = badgeRepo;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        if (authentication instanceof OAuth2AuthenticationToken token) {
            String registrationId = token.getAuthorizedClientRegistrationId(); // "github"
            OAuth2User oauthUser = token.getPrincipal();
            Map<String, Object> attrs = oauthUser.getAttributes();

            // GitHub typically provides: id, login, name, avatar_url, etc.
            String provider = registrationId.toUpperCase();          // "GITHUB"
            String providerId = String.valueOf(attrs.get("id"));     // GitHub numeric id
            String username = (String) attrs.get("login");           // GitHub username
            String email = (String) attrs.get("email");              // may be null

            User existing = userRepo.findByProviderAndProviderId(provider, providerId);
            if (existing == null) {
                User u = new User();
                u.setUsername(username != null ? username : ("github_" + providerId));
                u.setProvider(provider);
                u.setProviderId(providerId);
                u.setEmail(email);
                // password stays null
                u.setStreak(1);
                u.setLastLogin(LocalDate.now());
                //login badge
                Badge firstLogin = badgeRepo.findByName("First Login");
                if (firstLogin != null) {
                    u.getBadges().add(firstLogin);
                    request.getSession().setAttribute("badgeCelebration", "First Login");
                }

                request.getSession().setAttribute("streakCelebration", true);
                userRepo.save(u);

            } else {
                // optional: update email/username if changed
                if (email != null) existing.setEmail(email);
                if (username != null) existing.setUsername(username);
                // streak logic for login
                LocalDate today = LocalDate.now();
                LocalDate lastLogin = existing.getLastLogin();
                if (lastLogin != null) {
                    if (lastLogin.plusDays(1).equals(today)) {
                        existing.setStreak(existing.getStreak() + 1);
                        request.getSession().setAttribute("streakCelebration", true);
                    } else if (!lastLogin.equals(today)) {
                        existing.setStreak(1);
                        request.getSession().setAttribute("streakCelebration", true);
                        System.out.println("STREAK POPUP TRIGGERED");
                    }
                } else  {
                    existing.setStreak(1);
                    request.getSession().setAttribute("streakCelebration", true);
                }
                existing.setLastLogin(today);
                userRepo.save(existing);
            }
        }

        response.sendRedirect("/home");
    }

}

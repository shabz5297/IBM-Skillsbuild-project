package com.group05.config;

import com.group05.model.User;
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

@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepo userRepo;

    public OAuth2LoginSuccessHandler(UserRepo userRepo) {
        this.userRepo = userRepo;
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
                userRepo.save(u);
            } else {
                // optional: update email/username if changed
                if (email != null) existing.setEmail(email);
                if (username != null) existing.setUsername(username);
                userRepo.save(existing);
            }
        }

        response.sendRedirect("/home");
    }
}

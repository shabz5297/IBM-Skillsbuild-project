package com.group05.userservice;
import com.group05.model.Badge;
import com.group05.model.User;
import com.group05.repo.BadgeRepo;
import com.group05.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepo userRepo;


    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private BadgeRepo badgeRepo;

    public UserService(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    //register a user
    public void registerUser(String username, String password){
        validateUsername(username);
        validatePassword(password);

        //stop duplicate usernames
        if (userRepo.findByUsername(username) != null) {
            throw new IllegalArgumentException("Username is already taken.");
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        Badge firstLogin = badgeRepo.findByName("First Login");
        if (firstLogin != null) {
            user.getBadges().add(firstLogin);
        }
        userRepo.save(user);
    }

    public User findById(Long id) {
        return userRepo.findById(id).orElse(null);
    }

    public void save(User user) {
        userRepo.save(user);
    }

    private void validateUsername(String username) {
        if (username == null || username.isBlank()) {
            throw new IllegalArgumentException("Username is required.");
        }
        if (username.length() < 3 || username.length() > 30) {
            throw new IllegalArgumentException("Username must be 3–30 characters.");
        }
        if (!username.matches("^[A-Za-z0-9._-]+$")) {
            throw new IllegalArgumentException("Username can only contain letters, numbers, ., _, -");
        }
    }

    private void validatePassword(String password) {
        if (password == null) {
            throw new IllegalArgumentException("Password is required.");
        }
        if (password.length() < 8 || password.length() > 72) {
            throw new IllegalArgumentException("Password must be at least 8 characters.");
        }
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasDigit = password.matches(".*\\d.*");
        boolean hasSymbol = password.matches(".*[^A-Za-z0-9].*");

        if (!(hasLower && hasUpper && hasDigit && hasSymbol)) {
            throw new IllegalArgumentException(
                    "Password must include uppercase, lowercase, number, and symbol."
            );
        }
    }



}

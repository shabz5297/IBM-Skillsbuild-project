package com.group05.userservice;
import com.group05.model.User;
import com.group05.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepo userRepo;


    @Autowired
    private PasswordEncoder passwordEncoder;
    public UserService(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    //register a user
    public void registerUser(String username, String password){
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        userRepo.save(user);
    }

    public User findById(Long id) {
        return userRepo.findById(id).orElse(null);
    }

    public void save(User user) {
        userRepo.save(user);
    }




}

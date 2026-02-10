package com.group05.userservice;

import com.group05.model.User;
import com.group05.repo.UserRepo;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetails implements UserDetailsService {

    private UserRepo userRepo;

    public UserDetails(UserRepo userRepo) {this.userRepo = userRepo;}

    @Override
    public org.springframework.security.core.userdetails.UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {

//find username + exception handle
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return org.springframework.security.core.userdetails.User.
                withUsername(user.getUsername()).password(user.getPassword()).build();
    }
}


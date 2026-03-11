package com.group05;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


//Used for testing friends tab function, create passwords to insert into DB
//then test fron an active user account
public class PasswordGenerator {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        System.out.println(encoder.encode("password123"));
    }
}


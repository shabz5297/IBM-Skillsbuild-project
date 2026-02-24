package com.group05.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    // can be null for OAuth2 users
    private String password;

    //new fields for OAuth2 users
    private String provider;
    private String providerId;

    // Profile fields
    private String email;
    private String displayName;
    private String bio;
    private String profilePicture;

    @ManyToMany
    private List<Badge> badges = new ArrayList<>();

    public User() {}

    public Set<Course> getSavedCourses() {
        return savedCourses;
    }

    // Saved Courses
    @ManyToMany
    @JoinTable(
            name = "user_courses",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "course_id")
    )

    private Set<Course> savedCourses = new HashSet<>();
    private int progress=0;

    // Getters and Setters
    public Long getId() {return id;}
    public void setId(Long id) {this.id = id;}

    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}

    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}

    public String getProvider() { return provider;}
    public void setProvider(String provider) { this.provider = provider;}

    public String getProviderId() { return providerId;}
    public void setProviderId(String providerId) { this.providerId = providerId;}

    public String getEmail() { return email;}
    public void setEmail(String email) { this.email = email;}

    public String getDisplayName() {return displayName;}
    public void setDisplayName(String displayName) {this.displayName = displayName;}

    public String getBio() {return bio;}
    public void setBio(String bio) {this.bio = bio;}

    public String getProfilePicture() {return profilePicture;}
    public void setProfilePicture(String profilePicture) {this.profilePicture = profilePicture;}

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public List<Badge> getBadges() {
        return badges;
    }

    public void setBadges(List<Badge> badges) {
        this.badges = badges;
    }

}

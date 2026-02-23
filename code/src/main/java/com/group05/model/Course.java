package com.group05.model;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToMany(mappedBy = "savedCourses")
    private Set<User> users = new HashSet<>();

    private String title;
    private String category;
    private String description;
    private String link;

    // Empty constructor
    public Course() {}

    // Main Constructor
    public Course(String title, String category, String description, String link) {
        this.title = title;
        this.category = category;
        this.description = description;
        this.link = link;
    }

    // Getters & setters
    public Long getId() {return id;}
    public void setId(Long id) {this.id = id;}

    public String getTitle() {return title;}
    public void setTitle(String title) {this.title = title;}

    public String getCategory() {return category;}
    public void setCategory(String category) {this.category = category;}

    public String getDescription() {return description;}
    public void setDescription(String description) {this.description = description;}

    public String getLink() {return link;}
    public void setLink(String link) {this.link = link;}
}
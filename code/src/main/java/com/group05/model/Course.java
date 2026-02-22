package com.group05.model;

public class Course {

    private Long id;
    private String title;
    private String category;
    private String description;
    private String link;
    private boolean completed;

    // Empty constructor
    public Course() {}

    // Constructor you just added
    public Course(Long id, String title, String category, String description, String link) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.description = description;
        this.link = link;
    }

    // Getters & setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
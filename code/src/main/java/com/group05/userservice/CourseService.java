package com.group05.userservice;

import com.group05.model.Course;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();

        courses.add(new Course(
                1L,
                "Introduction to Artificial Intelligence",
                "AI",
                "Learn the basics of AI and machine learning concepts.",
                "https://skillsbuild.org/course/artificial-intelligence"
        ));

        courses.add(new Course(
                2L,
                "IBM Cloud Fundamentals",
                "Cloud",
                "Understand core cloud computing principles.",
                "https://skillsbuild.org/course/ibm-cloud"
        ));

        return courses;
    }
}
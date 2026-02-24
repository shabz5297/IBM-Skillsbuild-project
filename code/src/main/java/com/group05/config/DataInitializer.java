package com.group05.config;

import com.group05.model.Course;
import com.group05.repo.CourseRepo;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration // Marks this class as a Spring configuration class (used to define beans)
public class DataInitializer {

    @Bean // Tells Spring to run this method at application startup
    public ApplicationRunner initializer(CourseRepo courseRepository) {
        return args -> {

            // Check if the database already has courses
            // This prevents duplicate courses being inserted every time the app starts
            if (courseRepository.count() == 0) { // only add if DB is empty

                // Add starter courses to the database so the dashboard isn't empty
                courseRepository.save(new Course(
                        "Introduction to Artificial Intelligence",
                        "AI",
                        "Learn the basics of AI and machine learning concepts.",
                        "https://skillsbuild.org/course/artificial-intelligence"
                ));

                courseRepository.save(new Course(
                        "IBM Cloud Fundamentals",
                        "Cloud",
                        "Understand core cloud computing principles.",
                        "https://skillsbuild.org/course/ibm-cloud"
                ));

                courseRepository.save(new Course(
                        "Data Science 101",
                        "Data Science",
                        "Get started with data analysis and visualization.",
                        "https://skillsbuild.org/course/data-science"
                ));

                courseRepository.save(new Course(
                        "Introduction to Cybersecurity",
                        "Security",
                        "Learn the foundations of protecting systems and data.",
                        "https://skillsbuild.org/course/cybersecurity"
                ));
            }
        };
    }
}
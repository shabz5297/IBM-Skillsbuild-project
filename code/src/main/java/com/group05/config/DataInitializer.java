package com.group05.config;

import com.group05.model.Course;
import com.group05.repo.CourseRepo;
import com.group05.model.Badge;
import com.group05.repo.BadgeRepo;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {
    @Bean
    CommandLineRunner initData(BadgeRepo badgeRepo) {
        return args -> {

            if (badgeRepo.findByName("Beginner") == null) {
                badgeRepo.save(new Badge("Beginner"));
            }

            if (badgeRepo.findByName("Explorer") == null) {
                badgeRepo.save(new Badge("Explorer"));
            }

            if (badgeRepo.findByName("Socializer") == null) {
                badgeRepo.save(new Badge("Socializer"));
            }
        };
    }

    @Bean
    public ApplicationRunner initializer(CourseRepo courseRepository) {
        return args -> {

            // AI & Machine Learning
            insertIfMissing(courseRepository, new Course(
                    "Introduction to Artificial Intelligence",
                    "AI",
                    "Learn the basics of AI and machine learning concepts.",
                    "https://skillsbuild.org/college-students/course-catalog/artificial-intelligence-fundamentals"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Machine Learning with Python",
                    "AI",
                    "Build and train machine learning models using Python and scikit-learn.",
                    "https://skillsbuild.org/college-students/course-catalog/artificial-intelligence-fundamentals"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Deep Learning Fundamentals",
                    "AI",
                    "Explore neural networks and deep learning architectures.",
                    "https://skillsbuild.org/college-students/course-catalog/artificial-intelligence-fundamentals"
            ));

            // Cloud
            insertIfMissing(courseRepository, new Course(
                    "IBM Cloud Fundamentals",
                    "Cloud",
                    "Understand core cloud computing principles.",
                    "https://skillsbuild.org/students/course-catalog/cloud-computing"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Cloud Application Development",
                    "Cloud",
                    "Learn to design and deploy scalable applications on the cloud.",
                    "https://skillsbuild.org/students/course-catalog/cloud-computing"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Containers and Kubernetes",
                    "Cloud",
                    "Master containerisation with Docker and orchestration with Kubernetes.",
                    "https://skillsbuild.org/students/course-catalog/cloud-computing"
            ));

            // Data Science
            insertIfMissing(courseRepository, new Course(
                    "Data Science 101",
                    "Data Science",
                    "Get started with data analysis and visualization.",
                    "https://skillsbuild.org/students/course-catalog/data-science"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Data Analysis with Python",
                    "Data Science",
                    "Use pandas and matplotlib to analyse and visualise real-world datasets.",
                    "https://skillsbuild.org/students/course-catalog/data-science"
            ));

            insertIfMissing(courseRepository, new Course(
                    "SQL for Data Science",
                    "Data Science",
                    "Write powerful SQL queries to extract insights from relational databases.",
                    "https://skillsbuild.org/students/course-catalog/data-science"
            ));

            // Security
            insertIfMissing(courseRepository, new Course(
                    "Introduction to Cybersecurity",
                    "Security",
                    "Learn the foundations of protecting systems and data.",
                    "https://skillsbuild.org/college-students/course-catalog/cybersecurity-fundamentals"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Ethical Hacking Essentials",
                    "Security",
                    "Understand penetration testing techniques and how to think like an attacker.",
                    "https://skillsbuild.org/college-students/course-catalog/getting-started-with-cybersecurity"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Network Security Fundamentals",
                    "Security",
                    "Protect networks from threats with firewalls, VPNs, and intrusion detection.",
                    "https://skillsbuild.org/college-students/course-catalog/cloud-security"
            ));

            // Development
            insertIfMissing(courseRepository, new Course(
                    "Full Stack Web Development",
                    "Development",
                    "Build end-to-end web applications using modern front-end and back-end technologies.",
                    "https://skillsbuild.org/college-students/course-catalog"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Java Programming for Beginners",
                    "Development",
                    "Get started with Java, one of the world's most popular programming languages.",
                    "https://skillsbuild.org/college-students/course-catalog"
            ));

            insertIfMissing(courseRepository, new Course(
                    "DevOps Essentials",
                    "Development",
                    "Learn CI/CD pipelines, automation, and collaboration between dev and ops teams.",
                    "https://skillsbuild.org/college-students/course-catalog"
            ));

            // Business & Professional Skills
            insertIfMissing(courseRepository, new Course(
                    "Agile Project Management",
                    "Business",
                    "Manage projects effectively using Agile and Scrum methodologies.",
                    "https://skillsbuild.org/students/course-catalog/agile"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Design Thinking",
                    "Business",
                    "Apply human-centred design principles to solve complex problems creatively.",
                    "https://skillsbuild.org/students/course-catalog/agile"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Digital Marketing Fundamentals",
                    "Business",
                    "Understand SEO, social media, content marketing, and digital strategy.",
                    "https://skillsbuild.org/college-students/course-catalog"
            ));

            // Emerging Tech
            insertIfMissing(courseRepository, new Course(
                    "Blockchain Essentials",
                    "Emerging Tech",
                    "Discover how blockchain works and its real-world applications beyond cryptocurrency.",
                    "https://skillsbuild.org/students/course-catalog/blockchain"
            ));

            insertIfMissing(courseRepository, new Course(
                    "Introduction to Quantum Computing",
                    "Emerging Tech",
                    "Explore the principles of quantum mechanics and their application in computing.",
                    "https://skillsbuild.org/students/course-catalog/quantum-computing"
            ));
        };
    }

    private void insertIfMissing(CourseRepo courseRepository, Course course) {
        if (!courseRepository.existsByTitle(course.getTitle())) {
            courseRepository.save(course);
        }
    }
}
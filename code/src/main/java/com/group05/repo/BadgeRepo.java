package com.group05.repo;

import com.group05.model.Badge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BadgeRepo extends JpaRepository<Badge, Long> {
    Badge findByName(String name);
}

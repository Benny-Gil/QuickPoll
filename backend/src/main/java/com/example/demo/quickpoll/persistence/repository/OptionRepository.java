package com.example.demo.quickpoll.persistence.repository;

import com.example.demo.quickpoll.persistence.entity.OptionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OptionRepository extends JpaRepository<OptionEntity, Long> {
}
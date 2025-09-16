package com.example.demo.quickpoll.persistence.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "poll")
@Getter
@Setter
public class PollEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String question;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt = Instant.now();

    @OneToMany(mappedBy = "poll", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OptionEntity> options = new ArrayList<>();
}
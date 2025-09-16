package com.example.demo.quickpoll.core.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Option {
    private Long id;
    private String text;
    private int votes;
    private Long pollId;
}
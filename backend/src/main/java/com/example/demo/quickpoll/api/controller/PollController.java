package com.example.demo.quickpoll.api.controller;

import com.example.demo.quickpoll.api.dto.CreatePollRequest;
import com.example.demo.quickpoll.core.model.Poll;
import com.example.demo.quickpoll.core.service.PollService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/polls")
@RequiredArgsConstructor
public class PollController {
    private final PollService pollService;

    @GetMapping
    public List<Poll> listPolls() {
        return pollService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Poll> getPoll(@PathVariable Long id) {
        return pollService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Poll> createPoll(@Valid @RequestBody CreatePollRequest request) {
        Poll poll = pollService.create(request.question(), request.options());
        return ResponseEntity.ok(poll);
    }

    @PostMapping("/{pollId}/vote/{optionId}")
    public ResponseEntity<Poll> vote(@PathVariable Long pollId, @PathVariable Long optionId) {
        return pollService.vote(pollId, optionId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
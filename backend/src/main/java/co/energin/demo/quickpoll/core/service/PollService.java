package co.energin.demo.quickpoll.core.service;

import co.energin.demo.quickpoll.core.model.Poll;
import java.util.List;
import java.util.Optional;

public interface PollService {
    List<Poll> findAll();
    Optional<Poll> findById(Long id);
    Poll create(String question, List<String> options);
    Optional<Poll> vote(Long pollId, Long optionId);
}
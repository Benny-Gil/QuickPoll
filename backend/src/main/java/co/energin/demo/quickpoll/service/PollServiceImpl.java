package co.energin.demo.quickpoll.service;

import co.energin.demo.quickpoll.core.model.Option;
import co.energin.demo.quickpoll.core.model.Poll;
import co.energin.demo.quickpoll.core.service.PollService;
import co.energin.demo.quickpoll.persistence.entity.OptionEntity;
import co.energin.demo.quickpoll.persistence.entity.PollEntity;
import co.energin.demo.quickpoll.persistence.repository.OptionRepository;
import co.energin.demo.quickpoll.persistence.repository.PollRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PollServiceImpl implements PollService {
    private final PollRepository pollRepository;
    private final OptionRepository optionRepository;

    @Override
    public List<Poll> findAll() {
        return pollRepository.findAllWithOptions().stream()
                .map(this::mapToPoll)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<Poll> findById(Long id) {
        return pollRepository.findById(id).map(this::mapToPoll);
    }

    @Override
    @Transactional
    public Poll create(String question, List<String> options) {
        PollEntity poll = new PollEntity();
        poll.setQuestion(question);
        
        PollEntity savedPoll = pollRepository.save(poll);
        
        options.forEach(text -> {
            OptionEntity option = new OptionEntity();
            option.setText(text);
            option.setPoll(savedPoll);
            savedPoll.getOptions().add(option);
        });
        
        return mapToPoll(pollRepository.save(savedPoll));
    }

    @Override
    @Transactional
    public Optional<Poll> vote(Long pollId, Long optionId) {
        return optionRepository.findById(optionId)
                .filter(option -> option.getPoll().getId().equals(pollId))
                .map(option -> {
                    option.setVotes(option.getVotes() + 1);
                    optionRepository.save(option);
                    return mapToPoll(option.getPoll());
                });
    }

    private Poll mapToPoll(PollEntity entity) {
        Poll poll = new Poll();
        poll.setId(entity.getId());
        poll.setQuestion(entity.getQuestion());
        poll.setCreatedAt(entity.getCreatedAt());
        
        List<Option> options = entity.getOptions().stream()
                .map(this::mapToOption)
                .collect(Collectors.toList());
        poll.setOptions(options);
        
        return poll;
    }

    private Option mapToOption(OptionEntity entity) {
        Option option = new Option();
        option.setId(entity.getId());
        option.setText(entity.getText());
        option.setVotes(entity.getVotes());
        option.setPollId(entity.getPoll().getId());
        return option;
    }
}
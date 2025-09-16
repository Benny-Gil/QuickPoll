package co.energin.demo.quickpoll.core.model;

import lombok.Getter;
import lombok.Setter;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class Poll {
    private Long id;
    private String question;
    private Instant createdAt;
    private List<Option> options = new ArrayList<>();
}
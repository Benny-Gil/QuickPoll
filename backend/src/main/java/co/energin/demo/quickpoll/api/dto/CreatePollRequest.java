package co.energin.demo.quickpoll.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import java.util.List;

public record CreatePollRequest(
    @NotBlank(message = "Question is required")
    String question,
    
    @NotEmpty(message = "At least two options are required")
    @Size(min = 2, max = 10, message = "Number of options must be between 2 and 10")
    List<@NotBlank(message = "Option text cannot be blank") String> options
) {}
package co.ke.vergeinteractive.loginservice.model.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

import javax.validation.constraints.NotBlank;

@Getter
@AllArgsConstructor
@ToString
public class LoginRequest {
    @NotBlank
    private String username;

    @NotBlank
    private String password;
}

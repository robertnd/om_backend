package co.ke.vergeinteractive.loginservice.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Data
@AllArgsConstructor
public class Token {
    private Date issuedAt;
    private Date expiresAt;
    private Long durationInSeconds;
    private String accessToken;
    private String userName;
    private String email;
    private Set<String> roles;
    private Set<String> views;
}

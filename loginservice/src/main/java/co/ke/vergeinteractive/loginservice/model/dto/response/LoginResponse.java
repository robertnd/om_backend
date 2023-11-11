package co.ke.vergeinteractive.loginservice.model.dto.response;

import co.ke.vergeinteractive.loginservice.model.dto.Token;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginResponse {

    private String message;
    private String profileName;
    private Boolean authenticated;
    private Token token;
}

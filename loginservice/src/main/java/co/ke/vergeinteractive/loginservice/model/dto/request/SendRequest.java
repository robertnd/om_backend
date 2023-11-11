package co.ke.vergeinteractive.loginservice.model.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
public class SendRequest {
    private String phoneNumber;
    private String message;
}

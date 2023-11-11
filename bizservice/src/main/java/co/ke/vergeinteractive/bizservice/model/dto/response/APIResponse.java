package co.ke.vergeinteractive.bizservice.model.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIResponse {
    private String statusCode;
    private String message;
    private String trackingID;
    private Object data;
}

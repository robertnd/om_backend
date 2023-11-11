package co.ke.vergeinteractive.bizservice.model.dto.om;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class MVOnboardResult {

    //@JsonAlias("Message")
    private String Message;
    private String statusCode;
    private String trackingID;
}

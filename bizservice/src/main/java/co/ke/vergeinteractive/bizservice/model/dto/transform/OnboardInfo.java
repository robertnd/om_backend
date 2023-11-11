package co.ke.vergeinteractive.bizservice.model.dto.transform;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Data;

@Data
public class OnboardInfo {
    // class for extracting personal info from the onboard json object
    @JsonAlias("personalInfo")
    PersonalInfoDto personalInfo;

    @JsonAlias("contacts")
    ContactsDto contacts;

    @JsonAlias("occupation")
    OccupationDto occupation;
}

package co.ke.vergeinteractive.bizservice.service.workflow;

import co.ke.vergeinteractive.bizservice.model.dto.transform.ContactsDto;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OccupationDto;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OnboardInfo;
import co.ke.vergeinteractive.bizservice.model.dto.transform.PersonalInfoDto;
import co.ke.vergeinteractive.bizservice.model.entity.Contacts;
import co.ke.vergeinteractive.bizservice.model.entity.Customer;
import co.ke.vergeinteractive.bizservice.model.entity.Occupation;
import co.ke.vergeinteractive.bizservice.model.entity.Recommendation;
import co.ke.vergeinteractive.bizservice.service.db.DBService;
import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import co.ke.vergeinteractive.bizservice.utils.ModelMapperUtils;
import com.google.gson.Gson;
import io.undertow.server.RequestTooBigException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.javatuples.Pair;
import org.javatuples.Quartet;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@Log4j2
@RequiredArgsConstructor
public class WorkflowService {

    private final DBService dbService;

    Gson gson = ApiUtil.gsonBuilder();

    public Boolean onboard(Object request, String internalTrackingRef) {
        log.info("WorkflowService.onboard - {} - (START Workflow) ", internalTrackingRef);

        // Read JSON into Objects
        try {
            // weird errors
            String requestJson = gson.toJson(request);
            OnboardInfo onboardInfo = gson.fromJson(requestJson, OnboardInfo.class);
            return dbService.saveOnboard(onboardInfo, internalTrackingRef);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("WorkflowService.onboard - {} - JSON error - {}", internalTrackingRef, e.getMessage());
        }
        // failed
        return false;
    }

    public OnboardInfo prefill(String idType, String idNumber, String internalTrackingRef) {
        if ( !idType.isBlank() && !idNumber.isBlank() ) {
            return transform(dbService.getCustomer(idType, idNumber), internalTrackingRef);
        }
        return new OnboardInfo();
    }

    public Pair<OnboardInfo, Recommendation> prefillWithRecommends(String idType, String idNumber, String internalTrackingRef) {
        if ( !idType.isBlank() && !idNumber.isBlank() ) {
            OnboardInfo onboardInfo = transform(dbService.getCustomer(idType, idNumber), internalTrackingRef);
            if ( !Objects.isNull(onboardInfo)
                && !Objects.isNull(onboardInfo.getPersonalInfo())
                    && !Objects.isNull(onboardInfo.getPersonalInfo().getCustomerPid()) ) {
                Recommendation recommendation = dbService.getRecommendation("" + onboardInfo.getPersonalInfo().getCustomerPid());
                return new Pair<OnboardInfo, Recommendation>(onboardInfo, recommendation);
            }
        }
        return new Pair<OnboardInfo, Recommendation>(null, null);
    }

    public OnboardInfo prefill(String mobileNo, String internalTrackingRef) {
        if (!mobileNo.isBlank()) {
            return transform(dbService.getCustomer(mobileNo), internalTrackingRef);
        }
        return new OnboardInfo();
    }

    public Pair<OnboardInfo, Recommendation> prefillWithRecommends(String mobileNo, String internalTrackingRef) {
        if (!mobileNo.isBlank()) {
            OnboardInfo onboardInfo = transform(dbService.getCustomer(mobileNo), internalTrackingRef);
            if ( !Objects.isNull(onboardInfo)
                    && !Objects.isNull(onboardInfo.getPersonalInfo())
                        && !Objects.isNull(onboardInfo.getPersonalInfo().getCustomerPid()) ) {
                // :-) paranoia
                Recommendation recommendation = dbService.getRecommendation("" + onboardInfo.getPersonalInfo().getCustomerPid());
                return new Pair<OnboardInfo, Recommendation>(onboardInfo, recommendation);
            }
        }
        return new Pair<OnboardInfo, Recommendation>(null, null);
    }

    public OnboardInfo transform(Quartet<Boolean, Customer, Contacts, Occupation> customerInfo, String internalTrackingRef) {

        // catch and swallow
        try {
            //Quartet<Boolean, Customer, Contacts, Occupation> customerInfo = dbService.getCustomer(idType, idNumber);
            if (!customerInfo.getValue0()) {
                log.error("WorkflowService.transform - {} - customerInfo is empty ", internalTrackingRef);
                return new OnboardInfo();
            } else {
                PersonalInfoDto personalInfoDto = new PersonalInfoDto();
                ContactsDto contactsDto = new ContactsDto();
                OccupationDto occupationDto = new OccupationDto();

                if (!Objects.isNull(customerInfo.getValue1())) {
                    Customer customer = customerInfo.getValue1();
                    ModelMapperUtils.map(customer, personalInfoDto);
                    personalInfoDto.setMiddleNames(customer.getOtherNames());
                    personalInfoDto.setSurname(customer.getLastName());
                    personalInfoDto.setIdDocumentType(customer.getIdType());
                    personalInfoDto.setIdDocumentValue(customer.getIdNumber());
                    personalInfoDto.setGender(customer.getGender().equalsIgnoreCase("Male") ? "M" : "F");
                    personalInfoDto.setCustomerPid(customer.getCustomerPid());
                }

                if (!Objects.isNull(customerInfo.getValue2())) {
                    Contacts contacts = customerInfo.getValue2();
                    ModelMapperUtils.map(contacts, contactsDto);
                    contactsDto.setMobileNo(contacts.getMobileNumber());
                    contactsDto.setHomeNo(contacts.getHomeNumber());
                }

                if (!Objects.isNull(customerInfo.getValue3())) {
                    Occupation occupation = customerInfo.getValue3();
                    ModelMapperUtils.map(occupation, occupationDto);
                    occupationDto.setOccupationNarration(occupation.getOccupationDetails());
                    occupationDto.setWorkPostalAddress(occupation.getPostalAddress());
                    occupationDto.setWorkPostalCode(occupation.getPostalCode());
                    occupationDto.setWorkTownCity(occupation.getTownCity());
                    occupationDto.setWorkPhysicalAddress(occupation.getPhysicalAddress());
                    occupationDto.setWorkEmail(occupation.getEmail());
                    occupationDto.setWorkPhoneNo(occupation.getWorkNumber());
                }

                OnboardInfo onboardInfo = new OnboardInfo();
                onboardInfo.setPersonalInfo(personalInfoDto);
                onboardInfo.setContacts(contactsDto);
                onboardInfo.setOccupation(occupationDto);
                return onboardInfo;
            }
        } catch (Exception e) {
            log.error("WorkflowService.transform - {} - Exception - transform() failed with - {} ", internalTrackingRef, e.getMessage());
        }
        return new OnboardInfo();
    }

    public Recommendation getRecommendation(String customerPid) {
        return dbService.getRecommendation(customerPid);
    }
}

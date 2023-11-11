package co.ke.vergeinteractive.bizservice.service.db;

import co.ke.vergeinteractive.bizservice.model.dto.transform.ContactsDto;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OccupationDto;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OnboardInfo;
import co.ke.vergeinteractive.bizservice.model.dto.transform.PersonalInfoDto;
import co.ke.vergeinteractive.bizservice.model.entity.*;
import co.ke.vergeinteractive.bizservice.repository.*;
import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import co.ke.vergeinteractive.bizservice.utils.ModelMapperUtils;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.javatuples.Quartet;
import org.springframework.stereotype.Service;

import java.util.*;

@Log4j2
@Service
@RequiredArgsConstructor
public class DBService {

    private final CustomerRepo customerRepo;
    private final ContactsRepo contactsRepo;
    private final OccupationRepo occupationRepo;
    private final RecommendationsRepo recommendationsRepo;
    private final RecommendsSummaryRepo recommendsSummaryRepo;
    //private final EntityManager em;

    private Customer savePersonalInfo(PersonalInfoDto personalInfoDto) {
        Customer entity = new Customer();
        ModelMapperUtils.map(personalInfoDto, entity);
        entity.setOtherNames(personalInfoDto.getMiddleNames());
        entity.setLastName(personalInfoDto.getSurname());
        entity.setIdType(personalInfoDto.getIdDocumentType());
        entity.setIdNumber(personalInfoDto.getIdDocumentValue());
        entity.setGender(personalInfoDto.getGender().equalsIgnoreCase("M") ? "Male" : "Female");
        entity.setDataSource("NEW");
        entity.setStatus("NEW");
        return customerRepo.saveAndFlush(entity);
    }

    private Contacts saveContacts(ContactsDto contactsDto, Long customerID) {
        Contacts entity = new Contacts();
        ModelMapperUtils.map(contactsDto, entity);
        entity.setCustomerId(customerID);
        entity.setMobileNumber(contactsDto.getMobileNo());
        entity.setHomeNumber(contactsDto.getHomeNo());
        return contactsRepo.saveAndFlush(entity);
    }

    private Occupation saveOccupation(OccupationDto occupationDto, Long customerID) {
        Occupation entity = new Occupation();
        ModelMapperUtils.map(occupationDto, entity);
        entity.setCustomerId(customerID);
        entity.setOccupationDetails(occupationDto.getOccupationNarration());
        entity.setPostalAddress(occupationDto.getWorkPostalAddress());
        entity.setPostalCode(occupationDto.getWorkPostalCode());
        entity.setTownCity(occupationDto.getWorkTownCity());
        entity.setPhysicalAddress(occupationDto.getWorkPhysicalAddress());
        entity.setEmail(occupationDto.getWorkEmail());
        entity.setWorkNumber(occupationDto.getWorkPhoneNo());
        return occupationRepo.saveAndFlush(entity);
    }

    public Boolean saveOnboard(OnboardInfo onboardInfo, String internalTrackingRef) {

        log.info("DBService.saveOnboard - {} - (save customer, contacts, occupation) ", internalTrackingRef);
        try {
            Customer newSavedCustomer = savePersonalInfo(onboardInfo.getPersonalInfo());
            if ( !Objects.isNull(newSavedCustomer.getId()) ) {
                saveContacts(onboardInfo.getContacts(),newSavedCustomer.getId());
                saveOccupation(onboardInfo.getOccupation(),newSavedCustomer.getId());
                log.info("DBService.saveOnboard - {} - customer created ", internalTrackingRef);
                return true;
            } else {
                log.error("DBService.saveOnboard - {} - Save failed. Customer ID (BD) is empty", internalTrackingRef);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("DBService.saveOnboard - {} - Exception - {}", internalTrackingRef, e.getMessage());
        }
        return false;
    }

    public Quartet<Boolean, Customer, Contacts, Occupation> getCustomer(String idType, String idNumber) {
        try {
            List<Customer> byIdNumberAndIdType = customerRepo.findByIdNumberAndIdType(idNumber, idType);
            if (byIdNumberAndIdType.size() == 0) {
                return new Quartet<Boolean, Customer, Contacts, Occupation>(false, null, null, null);
            } else {
                Customer customer = byIdNumberAndIdType.get(0);
                List<Contacts> contacts = contactsRepo.findByCustomerId(customer.getId());
                List<Occupation> occupation = occupationRepo.findByCustomerId(customer.getId());
                // bleurghh :-(
                return new Quartet<Boolean, Customer, Contacts, Occupation>(
                        true,
                        customer,
                        contacts.size() > 0 ? contacts.get(0) : null,
                        occupation.size() > 0 ? occupation.get(0) : null);
            }
        } catch (Exception e) {
            return new Quartet<Boolean, Customer, Contacts, Occupation>(false, null, null, null);
        }
    }

    public Quartet<Boolean, Customer, Contacts, Occupation> getCustomer(String mobileNumber) {

        try {
            List<Contacts> contacts = contactsRepo.findByMobileNumber(mobileNumber);
            if (contacts.size() > 0) {
                Contacts contact = contacts.get(0);
                // very defensive ...
                if (!Objects.isNull(contact.getCustomerId())) {
                    Optional<Customer> maybeCustomer = customerRepo.findById(contact.getCustomerId());
                    if (maybeCustomer.isPresent()) {
                        List<Occupation> occupations = occupationRepo.findByCustomerId(maybeCustomer.get().getId());
                        if (occupations.size() > 0) {
                            Occupation occupation = occupations.get(0);
                            return new Quartet<Boolean, Customer, Contacts, Occupation>(
                                    true, maybeCustomer.get(), contact, occupation);
                        } else {
                            return new Quartet<Boolean, Customer, Contacts, Occupation>(
                                    true, maybeCustomer.get(), contact, null);
                        }
                    }
                }
            }
        } catch (Exception e) {

        }
        return new Quartet<Boolean, Customer, Contacts, Occupation>(false, null, null, null);
    }

    public Recommendation getRecommendation(String customerPid) {

        try {
            List<Recommendation> recommendations = recommendationsRepo.findByCustomerPid(customerPid);
            if (recommendations.size() > 0) {
                return recommendations.get(0);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Map<String, RecommendationSummary> getAllRecommendations() {

        List<RecommendationSummaryDto> allRecommends = recommendsSummaryRepo.findAllRecommends();
        Map<String, RecommendationSummary> all = new HashMap<>();
        try {
            for(int i=0; i<allRecommends.size(); i++) {
                RecommendationSummary obj = concretize(allRecommends.get(i));
                all.put(allRecommends.get(i).getCustomer_Pid(),obj);
                // TODO: ergonomics
//                if (i > 7) break;
            }
        } catch (Exception e) {
            log.error("DBService.getAllRecommendations - Exception - {}", e.getMessage());
        }
        return all;
    }

    public RecommendationSummary concretize(RecommendationSummaryDto proj) {

        RecommendationSummary inst = new RecommendationSummary();
        inst.setCustomerId(proj.getCustomer_Id());
        inst.setCustomerPid(proj.getCustomer_Pid());
        inst.setFirstName(proj.getFirst_Name());
        inst.setOtherNames(proj.getOther_Names());
        inst.setSurname(proj.getSurname());
        inst.setTitle(proj.getTitle());
        inst.setDateOfBirth(proj.getDate_Of_Birth());
        inst.setGender(proj.getGender());
        inst.setMaritalStatus(proj.getMarital_Status());
        inst.setIdType(proj.getId_Type());
        inst.setIdNumber(proj.getId_Number());
        inst.setPIN(proj.getPin());
        inst.setHeight(proj.getHeight());
        inst.setWeight(proj.getWeight());
        inst.setDataSource(proj.getData_Source());
        inst.setStatus(proj.getStatus());
        inst.setNationality(proj.getNationality());
        inst.setCountryOfResidence(proj.getCountry_Of_Residence());
        inst.setContactsId(proj.getContacts_Id());
        inst.setMobileNumber(proj.getMobile_Number());
        inst.setHomeNumber(proj.getHome_Number());
        inst.setPostalAddress(proj.getPostal_Address());
        inst.setPostalCode(proj.getPostal_Code());
        inst.setTownCity(proj.getTown_City());
        inst.setPhysicalAddress(proj.getPhysical_Address());
        inst.setEmail(proj.getEmail());
        inst.setOccupationId(proj.getOccupation_Id());
        inst.setOccupationType(proj.getOccupation_Type());
        inst.setOccupationDetails(proj.getOccupation_Details());
        inst.setJobTitle(proj.getJob_Title());
        inst.setWorkplaceName(proj.getWorkplace_Name());
        inst.setPostalAddressWork(proj.getPostal_Address_Work());
        inst.setPostalCodeWork(proj.getPostal_Code_Work());
        inst.setTownCityWork(proj.getTown_City_Work());
        inst.setPhysicalAddressWork(proj.getPhysical_Address_Work());
        inst.setWorkNumber(proj.getWork_Number());
        inst.setEmailWork(proj.getEmail_Work());
        inst.setRecommendationId(proj.getRecommendation_Id());
        inst.setTotProducts(proj.getTot_Products());
        inst.setNeedsMet(proj.getNeeds_Met());
        inst.setHealthProducts(proj.getHealth_Products());
        inst.setHealthRecommendations(proj.getHealth_Recommendations());
        inst.setInvestmentProducts(proj.getInvestment_Products());
        inst.setInvestmentRecommendations(proj.getInvestment_Recommendations());
        inst.setLifeProducts(proj.getLife_Products());
        inst.setLifeRecommendations(proj.getLife_Recommendations());
        inst.setMotorProducts(proj.getMotor_Products());
        inst.setMotorRecommendations(proj.getMotor_Recommendations());
        inst.setNonMotorProducts(proj.getNon_Motor_Products());
        inst.setNonMotorRecommendations(proj.getNon_Motor_Recommendations());
        inst.setTravelProducts(proj.getTravel_Products());
        inst.setTravelRecommendations(proj.getTravel_Recommendations());

        //inst.set
        return inst;



    }
}



package co.ke.vergeinteractive.bizservice.model.entity;

import lombok.*;
import javax.persistence.Column;

@Data
public class RecommendationSummary {

    @Column(name = "customer_id")
    private Long customerId;

    @Column(name = "customer_pid", length = 50)
    private String customerPid;

    @Column(name = "first_name", length = 50)
    private String firstName;

    @Column(name = "other_names", length = 50)
    private String otherNames;

    @Column(name = "surname", length = 50)
    private String surname;

    @Column(name = "title", length = 50)
    private String title;

    @Column(name = "date_of_birth", length = 50)
    private String dateOfBirth;

    @Column(name = "gender", length = 50)
    private String gender;

    @Column(name = "marital_status", length = 50)
    private String maritalStatus;

    @Column(name = "id_type", length = 50)
    private String idType;

    @Column(name = "id_number", length = 50)
    private String idNumber;

    @Column(name = "PIN", length = 50)
    private String PIN;

    @Column(name = "height", length = 50)
    private String height;

    @Column(name = "weight", length = 50)
    private String weight;

    @Column(name = "data_source", length = 50)
    private String dataSource;

    @Column(name = "status", length = 50)
    private String status;

    @Column(name = "nationality", length = 50)
    private String nationality;

    @Column(name = "country_of_residence", length = 50)
    private String countryOfResidence;

    @Column(name = "contacts_id")
    private Long contactsId;

    @Column(name = "mobile_number", length = 50)
    private String mobileNumber;

    @Column(name = "home_number", length = 50)
    private String homeNumber;

    @Column(name = "postal_address", length = 50)
    private String postalAddress;

    @Column(name = "postal_code", length = 50)
    private String postalCode;

    @Column(name = "town_city", length = 50)
    private String townCity;

    @Column(name = "physical_address", length = 50)
    private String physicalAddress;

    @Column(name = "email", length = 50)
    private String email;

    @Column(name = "occupation_id")
    private Long occupationId;

    @Column(name = "occupation_type", length = 50)
    private String occupationType;

    @Column(name = "occupation_details", length = 50)
    private String occupationDetails;

    @Column(name = "job_title", length = 50)
    private String jobTitle;

    @Column(name = "workplace_name", length = 50)
    private String workplaceName;

    @Column(name = "postal_address_work", length = 50)
    private String postalAddressWork;

    @Column(name = "postal_code_work", length = 50)
    private String postalCodeWork;

    @Column(name = "town_city_work", length = 50)
    private String townCityWork;

    @Column(name = "physical_address_work", length = 50)
    private String physicalAddressWork;

    @Column(name = "work_number", length = 50)
    private String workNumber;

    @Column(name = "email_work", length = 50)
    private String emailWork;

    @Column(name = "recommendation_id")
    private Long recommendationId;

    @Column(name = "tot_products", length = 10)
    private String totProducts;

    @Column(name = "needs_met", length = 10)
    private String needsMet;

    @Column(name = "life_products", length = 300)
    private String lifeProducts;

    @Column(name = "life_recommendations", length = 300)
    private String lifeRecommendations;

    @Column(name = "motor_products", length = 300)
    private String motorProducts;

    @Column(name = "motor_recommendations", length = 300)
    private String motorRecommendations;

    @Column(name = "non_motor_products", length = 300)
    private String nonMotorProducts;

    @Column(name = "non_motor_recommendations", length = 300)
    private String nonMotorRecommendations;

    @Column(name = "travel_products", length = 300)
    private String travelProducts;

    @Column(name = "travel_recommendations", length = 300)
    private String travelRecommendations;

    @Column(name = "health_products", length = 300)
    private String healthProducts;

    @Column(name = "health_recommendations", length = 300)
    private String healthRecommendations;

    @Column(name = "investment_products", length = 300)
    private String investmentProducts;

    @Column(name = "investment_recommendations", length = 300)
    private String investmentRecommendations;
}

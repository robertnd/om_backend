package co.ke.vergeinteractive.bizservice.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Table(name = "OCCUPATION")
public class Occupation extends BaseEntity {

    @Column(name = "customer_id")
    private Long customerId;

    @Column(name = "customer_pid", length = 50)
    private String customerPid;

    @Column(name = "occupation_type", length = 50)
    private String occupationType;

    @Column(name = "occupation_details", length = 200)
    private String occupationDetails;

    @Column(name = "workplace_name", length = 50)
    private String workplaceName;

    @Column(name = "job_title", length = 50)
    private String jobTitle;

    @Column(name = "postal_address", length = 100)
    private String postalAddress;

    @Column(name = "postal_code", length = 30)
    private String postalCode;

    @Column(name = "town_city", length = 50)
    private String townCity;

    @Column(name = "physical_address", length = 200)
    private String physicalAddress;

    @Column(name = "work_number", length = 50)
    private String workNumber;

    @Column(name = "email", length = 100)
    private String email;

}

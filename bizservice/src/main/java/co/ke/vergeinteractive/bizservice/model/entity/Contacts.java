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
@Table(name = "CONTACTS")
public class Contacts extends BaseEntity {

    @Column(name = "customer_id")
    private Long customerId;

    @Column(name = "customer_pid", length = 50)
    private String customerPid;

    @Column(name = "postal_address", length = 100)
    private String postalAddress;

    @Column(name = "postal_code", length = 30)
    private String postalCode;

    @Column(name = "town_city", length = 50)
    private String townCity;

    @Column(name = "physical_address", length = 200)
    private String physicalAddress;

    @Column(name = "mobile_number", length = 50)
    private String mobileNumber;

    @Column(name = "home_number", length = 50)
    private String homeNumber;

    @Column(name = "email", length = 50)
    private String email;
}

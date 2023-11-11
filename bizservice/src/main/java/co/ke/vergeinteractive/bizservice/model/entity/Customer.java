package co.ke.vergeinteractive.bizservice.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Table(name = "CUSTOMER")
public class Customer extends BaseEntity {

    @Column(name = "customer_pid", length = 50)
    private String customerPid;

    @Column(name = "first_name", length = 50)
    private String firstName;

    @Column(name = "other_names", length = 200)
    private String otherNames;

    @Column(name = "surname", length = 50)
    private String lastName;

    @Column(name = "id_type", length = 20)
    private String idType;

    @Column(name = "id_number", length = 50)
    private String idNumber;

    @Column(name = "date_of_birth", length = 20)
    private String dateOfBirth;

    @Column(name = "height")
    private Float height;

    @Column(name = "weight")
    private Float weight;

    @Column(name = "gender", length = 20)
    private String gender;

    @Column(name = "marital_status", length = 20)
    private String maritalStatus;

    @Column(name = "PIN", length = 20)
    private String PIN;

    @Column(name = "nationality", length = 30)
    private String nationality;

    @Column(name = "country_of_residence", length = 30)
    private String countryOfResidence;

    @Column(name = "title", length = 20)
    private String title;

    @Column(name = "data_source", length = 20)
    private String dataSource;

    @Column(name = "status", length = 20)
    private String status;
}

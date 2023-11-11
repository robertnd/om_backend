package co.ke.vergeinteractive.bizservice.repository;

import co.ke.vergeinteractive.bizservice.model.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerRepo extends JpaRepository<Customer, Long> {
    List<Customer> findByIdNumber(String idNumber);
    List<Customer> findByCustomerPid(String customerPid);
    List<Customer> findByIdNumberAndIdType(String idNumber, String idType);
}

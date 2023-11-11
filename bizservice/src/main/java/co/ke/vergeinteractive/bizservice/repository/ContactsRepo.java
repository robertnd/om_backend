package co.ke.vergeinteractive.bizservice.repository;

import co.ke.vergeinteractive.bizservice.model.entity.Contacts;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContactsRepo extends JpaRepository<Contacts, Long> {
    List<Contacts> findByCustomerId(Long customerId);
    List<Contacts> findByCustomerPid(String customerPid);
    List<Contacts> findByMobileNumber(String mobileNumber);
}


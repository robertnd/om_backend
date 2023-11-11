package co.ke.vergeinteractive.bizservice.repository;

import co.ke.vergeinteractive.bizservice.model.entity.Occupation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface OccupationRepo extends JpaRepository<Occupation, Long> {
    List<Occupation> findByCustomerId(Long customerId);
    List<Occupation> findByCustomerPid(String customerPid);
}

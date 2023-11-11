package co.ke.vergeinteractive.bizservice.repository;

import co.ke.vergeinteractive.bizservice.model.entity.Contacts;
import co.ke.vergeinteractive.bizservice.model.entity.Recommendation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RecommendationsRepo extends JpaRepository<Recommendation, Long> {

    List<Recommendation> findByCustomerPid(String customerPid);
}

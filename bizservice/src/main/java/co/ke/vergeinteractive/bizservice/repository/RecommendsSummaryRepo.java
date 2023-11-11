package co.ke.vergeinteractive.bizservice.repository;

import co.ke.vergeinteractive.bizservice.model.entity.Contacts;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import java.util.List;

public interface RecommendsSummaryRepo extends Repository<Contacts, Long> {

    @Query(nativeQuery = true, value = "SELECT * FROM recommendationssummary")
    List<RecommendationSummaryDto> findAllRecommends();
}

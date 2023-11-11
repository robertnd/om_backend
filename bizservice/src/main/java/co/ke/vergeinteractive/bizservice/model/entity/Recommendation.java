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
@Table(name = "RECOMMENDATION")
public class Recommendation extends BaseEntity {

    @Column(name = "customer_pid", length = 50)
    private String customerPid;

    @Column(name = "customer_id")
    private Long customerId;

    @Column(name = "tot_products", length = 10)
    private String totProducts;

    @Column(name = "needs_met", length = 10)
    private String needsMet;

    @Column(name = "life_products", length = 300)
    private String lifeProducts;

    @Column(name = "motor_products", length = 300)
    private String motorProducts;

    @Column(name = "non_motor_products", length = 300)
    private String nonMotorProducts;

    @Column(name = "travel_products", length = 300)
    private String travelProducts;

    @Column(name = "health_products", length = 300)
    private String healthProducts;

    @Column(name = "investment_products", length = 300)
    private String investmentProducts;

    @Column(name = "life_recommendations", length = 300)
    private String lifeRecommendations;

    @Column(name = "motor_recommendations", length = 300)
    private String motorRecommendations;

    @Column(name = "non_motor_recommendations", length = 300)
    private String nonMotorRecommendations;

    @Column(name = "travel_recommendations", length = 300)
    private String travelRecommendations;

    @Column(name = "health_recommendations", length = 300)
    private String healthRecommendations;

    @Column(name = "investment_recommendations", length = 300)
    private String investmentRecommendations;
}

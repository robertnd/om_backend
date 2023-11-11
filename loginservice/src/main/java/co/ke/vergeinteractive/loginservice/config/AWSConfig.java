package co.ke.vergeinteractive.loginservice.config;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.AmazonSNSClient;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class AWSConfig {

    static {
        System.setProperty("aws.accessKeyId", "");
        System.setProperty("aws.secretKey", "");
    }

    @Bean
    public AmazonSNS client() {

        return AmazonSNSClient
                .builder()
                .withRegion(Regions.US_EAST_1)
                .build();
    }
}

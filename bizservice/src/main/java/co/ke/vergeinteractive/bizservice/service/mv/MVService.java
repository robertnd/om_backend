package co.ke.vergeinteractive.bizservice.service.mv;

import co.ke.vergeinteractive.bizservice.model.dto.om.MVOnboardResult;
import co.ke.vergeinteractive.bizservice.model.dto.response.APIResponse;
import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class MVService {

    @Value("${om.onboarding.motorvehicle.endpoint}")
    private String mvOnboardingEP;

    @Value("${om.subscription.key}")
    private String subscriptionKey;

    private final Gson gson = ApiUtil.gsonBuilder();

    public APIResponse mvProxy(Object request, String internalTrackingRef) {
        HttpEntity<?> entity = new HttpEntity<>(request, ApiUtil.headers(subscriptionKey));
        String url = mvOnboardingEP;
        //String url = "https://webhook.site/b172300f-9380-44b5-8d0d-080d6e5319b2";
        //String url = "https://run.mocky.io/v3/31e6e9fc-5c5f-450e-969a-c4448e8fd00a";
        MVOnboardResult result = null;
        try {
            log.info("MVService.mvProxy - {} - Target URL - {}", internalTrackingRef, url);
            log.info("MVService.mvProxy - {} - Request POST object - {}", internalTrackingRef, gson.toJson(entity));
            String rawResponse = ApiUtil.doApiCall(url, HttpMethod.POST, entity, new String());
            log.info("MVService.mvProxy - {} - Raw POST response from [{}] - {}", internalTrackingRef, url, gson.toJson(rawResponse));
            result = gson.fromJson(rawResponse, MVOnboardResult.class);
            return new APIResponse(result.getStatusCode(), result.getMessage(), result.getTrackingID(),null);
        } catch (Exception e) {
            log.error("MVService.mvProxy - {} - Exception - {}", internalTrackingRef, e.getMessage());
            return new APIResponse("500", e.getMessage(), "",null);
        }
    }
}

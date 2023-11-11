package co.ke.vergeinteractive.bizservice.utils;


import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import lombok.extern.log4j.Log4j2;
import org.javatuples.Pair;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Objects;
import java.util.UUID;
import java.util.function.Function;
import java.util.logging.Level;

@Log4j2
public class ApiUtil {

    private static final Gson gson = new GsonBuilder()
            .addSerializationExclusionStrategy(
                    new ExclusionStrategy() {
                        @Override
                        public boolean shouldSkipField(FieldAttributes f) {
                            return f.getAnnotation(Skip.class) != null;
                        }

                        @Override
                        public boolean shouldSkipClass(Class<?> clazz) {
                            return false;
                        }
                    }).disableHtmlEscaping().create();

    private static RestTemplate restTemplate = new RestTemplate();

    public static String generateRef() {
        return UUID.randomUUID().toString();
    }

    public static final Gson gsonBuilder() {
        return gson;
    }

    public static <T> T doApiCall(String url, HttpMethod httpMethod, HttpEntity httpEntity, T instance) {
        return (T) restTemplate.exchange(url, httpMethod, httpEntity, instance.getClass()).getBody();
    }

    public static <T> T doApiCall(RestTemplate timedRestTemplate, String url, HttpMethod httpMethod, HttpEntity httpEntity, T instance) {
        return (T) timedRestTemplate.exchange(url, httpMethod, httpEntity, instance.getClass()).getBody();
    }

    public static HttpHeaders headers(String token) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
        //headers.set("Authorization", token.startsWith("Bearer ") ? token : "Bearer " + token);
        headers.set("Ocp-Apim-Subscription-Key", token);
        return headers;
    }

    public static Pair<Boolean, String> checkAuth(HttpHeaders headers, Function<String, Pair<Boolean, String>> authorizer) {
        String token = headers.containsKey("Authorization") ? Objects.requireNonNull(headers.get("Authorization")).get(0) : "";
        Boolean authorized = false;
        String msg = "";
        if (!token.isEmpty()) {
            Pair<Boolean, String> checkAuthorized = authorizer.apply(token);
            authorized = checkAuthorized.getValue0();
            msg = authorized ? "Authorized" : "Unauthorized: " + checkAuthorized.getValue1();
        } else {
            msg = "Unauthorized: Request requires valid token";
        }

        return new Pair<>(authorized, msg);
    }

    public static String calculateSignature(String data, String secret) {
        try {
            String secretBase64 = Base64.getEncoder().encodeToString(secret.getBytes());
            Mac sha512Hmac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(secretBase64.getBytes(), "HmacSHA512");
            sha512Hmac.init(secretKey);
            byte[] signedBytes = sha512Hmac.doFinal(data.getBytes());
            String signature = Base64.getUrlEncoder().withoutPadding().encodeToString(signedBytes);
            return signature;
        } catch (Exception ex) {
            return "";
        }
    }
}


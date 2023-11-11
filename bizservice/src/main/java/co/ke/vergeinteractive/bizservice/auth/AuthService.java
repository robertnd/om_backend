package co.ke.vergeinteractive.bizservice.auth;

import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.codec.binary.Base64;
import org.javatuples.Pair;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class AuthService {

    @Value("${bizservice.verify-token:false}")
    private Boolean verifyToken;

    @Value("${bizservice.auth.issuer-url}")
    private String issuerEndpoint;

    @Value("${bizservice.jwt.secret}")
    private String secret;

    public Pair<Boolean, String> validateToken(String token) {

        if (!verifyToken) {
            return new Pair<>(true, "Verification is disabled");
        }
        //verify by properties
        try {
            //String newToken = token.contains("Bearer ") ? "{ " + token.split("Bearer ")[1] + " }" : "{ " + token + " }";
            String newToken = token.contains("Bearer ") ? token.split("Bearer ")[1] : token;
            DecodedJWT decodedToken = JWT.decode(newToken);
            String header = decodedToken.getHeader();
            String payload = decodedToken.getPayload();
            String calculatedSignature = ApiUtil.calculateSignature(header + "." + payload, secret);
            String tokenSignature = decodedToken.getSignature();
            System.out.println(tokenSignature);
            if (!decodedToken.getSignature().equalsIgnoreCase(calculatedSignature)) {
                return new Pair<>(false, " Token signature is invalid");
            }

            String issuerUrl = issuerEndpoint;
            if ( !decodedToken.getIssuer().equalsIgnoreCase(issuerUrl) ) {
                return new Pair<>(false, " Issuer mismatch");
            }

            Date expiresAt = decodedToken.getExpiresAt();
            Date dateNow = new Date();

            if ( expiresAt.before(dateNow) ) {
                return new Pair<>(false, "Token is expired");
            }
        } catch (Exception e) {
            log.error(e);
            return new Pair<>(false, e.getMessage());
        }
        return new Pair<>(true, "Token is valid");
    }
}

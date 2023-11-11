package co.ke.vergeinteractive.loginservice.service;

import co.ke.vergeinteractive.loginservice.model.dto.Token;
import co.ke.vergeinteractive.loginservice.model.entity.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.util.*;
import java.time.Instant;
import java.util.stream.Collectors;

@Service
public class TokenGeneratorService {

    @Value("${loginservice.jwt.secret}")
    private String jwtSecret;

    @Value("${loginservice.jwt.issuer}")
    private String issuer;

    @Value("${loginservice.jwt.validity-in-ms:900}")
    private Long tokenDuration;

    @Value("${loginservice.cookie:loginserviceCk}")
    private String cookie;

    @Value("${loginservice.cookie.max-age-seconds:7200}")
    private Long cookieAgeInSeconds;

    public Token tokenBuilder(User user, Collection<? extends GrantedAuthority> roles) throws UnsupportedEncodingException {

        Set<String> rolesList = roles.stream().map(role -> role.getAuthority()).collect(Collectors.toSet());
        Map<String, Object> claims = new HashMap<>();
        claims.put("userid", user.getUsername());
        claims.put("sub", user.getEmail());
        claims.put("iss", issuer);
        claims.put("aud", rolesList);
        Instant now = Instant.now();
        Instant then = now.plusSeconds(tokenDuration);
        String jwtSecretB64 = Base64.getEncoder().encodeToString(jwtSecret.getBytes());
        String token = Jwts.builder()
                .setHeaderParam("typ","JWT")
                .setClaims(claims)
                .setIssuedAt(Date.from(now))
                .setExpiration(Date.from(then))
                .setNotBefore(Date.from(now))
                .signWith(
                        SignatureAlgorithm.HS512,
                        jwtSecretB64.getBytes()
                )
                .compact();

        return new Token(Date.from(now),
                Date.from(then),
                tokenDuration,
                token,
                user.getUsername(),
                user.getEmail(),
                rolesList,
                user.getViews()
                );
    }

    public ResponseCookie generateCookie(Token tokenObj) {
        return ResponseCookie
                .from(cookie, tokenObj.getAccessToken())
                .path("/user")
                .maxAge(cookieAgeInSeconds)
                .httpOnly(true)
                .build();
    }

    public ResponseCookie resetCookie() {
        return ResponseCookie
                .from(cookie, null)
                .path("/user")
                .build();
    }
}

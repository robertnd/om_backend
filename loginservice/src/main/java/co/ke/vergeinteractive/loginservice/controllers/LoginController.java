package co.ke.vergeinteractive.loginservice.controllers;

import co.ke.vergeinteractive.loginservice.model.dto.Token;
import co.ke.vergeinteractive.loginservice.model.dto.UserDetailsImpl;
import co.ke.vergeinteractive.loginservice.model.dto.request.LoginRequest;
import co.ke.vergeinteractive.loginservice.model.dto.response.LoginResponse;
import co.ke.vergeinteractive.loginservice.model.entity.User;
import co.ke.vergeinteractive.loginservice.service.TokenGeneratorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.Collection;

@CrossOrigin
@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class LoginController {

    private final AuthenticationManager authManager;
    private final TokenGeneratorService tokenService;

    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

        try {
            System.out.println("Request received: " + loginRequest);
            Authentication authentication = authManager
                    .authenticate(new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
            SecurityContextHolder.getContext().setAuthentication(authentication);
            UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
            User user = userDetails.getUser();
            Token token = tokenService.tokenBuilder(user, userDetails.getAuthorities());
            LoginResponse success = new LoginResponse("Login successful", user.getProfileName(), true, token);
            System.out.println("Response:" + success);
            System.out.println("Request ends .....");
            ResponseCookie cookie = tokenService.generateCookie(token);
            System.out.println("COOKIE: " + cookie.toString());
            return ResponseEntity
                    .ok()
                    .header(HttpHeaders.SET_COOKIE, cookie.toString())
                    .body(success);
        } catch (Exception e) {
            e.printStackTrace();
            LoginResponse fail = new LoginResponse("Login failed: " + e.getMessage(), "", false, null);
            System.out.println("Failed with: " + e.getMessage());
            System.out.println("Response:" + fail);
            return ResponseEntity
                    .ok()
                    .body(fail);
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logoutUser() {
        ResponseCookie cookie = tokenService.resetCookie();
        LoginResponse signedOut = new LoginResponse("You have been signed out", "",false, null);
        System.out.println("Signed out:" + signedOut);
        return ResponseEntity
                .ok()
                .header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(signedOut);
    }
}

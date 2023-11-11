package co.ke.vergeinteractive.loginservice.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class User {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String username;
    private String profileName;
    private String email;
    @JsonIgnore
    private String password;
    private Set<String> roles = new HashSet<>();
    private Set<String> canView = new HashSet<>();

    //private Set<Role> roles = new HashSet<>();
    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public void setViews(Set<String> views) {
        this.canView = views;
    }

    public Set<String>  getViews() {

        return canView;
    }
}

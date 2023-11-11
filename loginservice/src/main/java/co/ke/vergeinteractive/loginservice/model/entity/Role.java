package co.ke.vergeinteractive.loginservice.model.entity;

import lombok.Data;

@Data
public class Role {

    private static final long serialVersionUID = 1L;
    private Long id;
    private ERole name;

    public Role(ERole role) {
        name = role;
    }
}

package edu.wpi.cs.dbms.domain.dto.user;

import lombok.Value;

@Value
public class CreateUserRequest {
    String email;
    String username;
    String password;
    String lastName;
    String firstName;
}

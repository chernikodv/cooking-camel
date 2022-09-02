package edu.wpi.cs.dbms.domain.dto.authentication;

import lombok.Value;

@Value
public class SignInRequest {
    String username;
    String password;
}

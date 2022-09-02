package edu.wpi.cs.dbms.domain.dto.authentication;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class SignInResponse {
    String jwt;
    Integer code;
}

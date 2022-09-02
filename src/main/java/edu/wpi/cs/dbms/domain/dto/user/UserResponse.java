package edu.wpi.cs.dbms.domain.dto.user;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class UserResponse {
    String email;
    String username;
    String lastName;
    String firstName;
    Boolean administrator;
}

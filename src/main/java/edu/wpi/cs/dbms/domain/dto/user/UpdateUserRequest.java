package edu.wpi.cs.dbms.domain.dto.user;

import lombok.Value;

@Value
public class UpdateUserRequest {
    String email;
    String lastName;
    String firstName;
    String oldPassword;
    String newPassword;
}

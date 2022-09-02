package edu.wpi.cs.dbms.mapper;

import edu.wpi.cs.dbms.domain.dto.user.CreateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UpdateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UserResponse;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.exception.PasswordMatchException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserMapper {

    private final PasswordEncoder passwordEncoder;

    public UserResponse mapEntityToResponse(User user) {
        return UserResponse.builder()
                .email(user.getEmail())
                .username(user.getUsername())
                .lastName(user.getLastName())
                .firstName(user.getFirstName())
                .administrator(user.getAdministrator())
                .build();
    }

    public User mapCreateRequestToEntity(CreateUserRequest createUserRequest) {
        final User user = new User();
        user.setAdministrator(false);
        user.setEmail(createUserRequest.getEmail());
        user.setUsername(createUserRequest.getUsername());
        user.setLastName(createUserRequest.getLastName().trim());
        user.setFirstName(createUserRequest.getFirstName().trim());
        user.setPassword(passwordEncoder.encode(createUserRequest.getPassword()));

        return user;
    }

    public User mapUpdateRequestToExistingEntity(UpdateUserRequest updateUserRequest, User user) {
        user.setEmail(updateUserRequest.getEmail());
        user.setLastName(updateUserRequest.getLastName().trim());
        user.setFirstName(updateUserRequest.getFirstName().trim());

        final String oldPasswordFromRequest = updateUserRequest.getOldPassword();
        if (oldPasswordFromRequest == null) {
            return user;
        }

        if (!passwordEncoder.matches(oldPasswordFromRequest, user.getPassword())) {
            throw new PasswordMatchException("Current password does not match with the provided password ...");
        }

        user.setPassword(passwordEncoder.encode(updateUserRequest.getNewPassword()));
        return user;
    }
}

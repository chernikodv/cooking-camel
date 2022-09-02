package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.user.CreateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UpdateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UserResponse;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.mapper.UserMapper;
import edu.wpi.cs.dbms.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;
    private final UserRepository userRepository;
    private final AuthenticationTokenInfoExtractor authenticationTokenInfoExtractor;

    public UserResponse create(CreateUserRequest createUserRequest) {
        final User user = userMapper.mapCreateRequestToEntity(createUserRequest);
        final User savedUser = userRepository.save(user);
        return userMapper.mapEntityToResponse(savedUser);
    }

    public UserResponse update(UpdateUserRequest updateUserRequest) {
        final String username = authenticationTokenInfoExtractor.getUsername();
        final User user = userMapper.mapUpdateRequestToExistingEntity(updateUserRequest, findById(username));
        final User updatedUser = userRepository.save(user);
        return userMapper.mapEntityToResponse(updatedUser);
    }

    public UserResponse findByUsername(String username) {
        final User user = findById(username);
        return userMapper.mapEntityToResponse(user);
    }

    public User findById(String username) {
        final Optional<User> maybeUser = userRepository.findById(username);
        return maybeUser.orElseThrow(() -> new NoSuchElementException("Could not find a user by the given username!"));
    }
}

package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.user.CreateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UpdateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UserResponse;
import edu.wpi.cs.dbms.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/api/users")
@CrossOrigin(origins = "http://localhost:3000/")
public class UserController {

    private final UserService userService;

    @PostMapping
    public UserResponse create(@RequestBody CreateUserRequest createUserRequest) {
        return userService.create(createUserRequest);
    }

    @PutMapping
    public UserResponse update(@RequestBody UpdateUserRequest updateUserRequest) {
        return userService.update(updateUserRequest);
    }

    @GetMapping(path = "/{username}")
    public UserResponse findByUsername(@PathVariable String username) {
        return userService.findByUsername(username);
    }
}

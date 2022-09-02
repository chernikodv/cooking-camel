package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.user.CreateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UpdateUserRequest;
import edu.wpi.cs.dbms.domain.dto.user.UserResponse;
import edu.wpi.cs.dbms.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000/")
@RequestMapping(path = "/api/users")
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

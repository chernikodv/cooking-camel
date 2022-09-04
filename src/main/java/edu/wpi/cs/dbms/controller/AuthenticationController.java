package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.authentication.SignInRequest;
import edu.wpi.cs.dbms.domain.dto.authentication.SignInResponse;
import edu.wpi.cs.dbms.service.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/api/authentication")
@CrossOrigin(origins = "http://localhost:3000/")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping(path = "/sign-in")
    public SignInResponse signIn(@RequestBody SignInRequest signInRequest) {
        return authenticationService.signIn(signInRequest);
    }
}

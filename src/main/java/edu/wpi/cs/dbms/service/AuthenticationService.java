package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.authentication.SignInRequest;
import edu.wpi.cs.dbms.domain.dto.authentication.SignInResponse;
import edu.wpi.cs.dbms.security.token.AuthenticationTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final AuthenticationManager authenticationManager;
    private final AuthenticationTokenProvider authenticationTokenProvider;

    public SignInResponse signIn(SignInRequest signInRequest) {
        final UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                signInRequest.getUsername(),
                signInRequest.getPassword()
        );
        final Authentication authentication = authenticationManager.authenticate(authenticationToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        final String jwt = authenticationTokenProvider.generate(authentication);
        return SignInResponse.builder()
                .jwt(jwt)
                .code(HttpStatus.OK.value())
                .build();
    }
}

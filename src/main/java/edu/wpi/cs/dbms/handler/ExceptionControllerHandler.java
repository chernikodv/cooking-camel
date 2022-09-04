package edu.wpi.cs.dbms.handler;

import edu.wpi.cs.dbms.domain.dto.GenericResponse;
import edu.wpi.cs.dbms.exception.PasswordMatchException;
import edu.wpi.cs.dbms.exception.ResourceViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.NoSuchElementException;

@RestControllerAdvice
public class ExceptionControllerHandler {

    @ExceptionHandler(value = NoSuchElementException.class)
    public ResponseEntity<GenericResponse> handleNoSuchElementException(Exception e) {
        final HttpStatus status = HttpStatus.NOT_FOUND;
        return ResponseEntity
                .status(status)
                .body(GenericResponse.builder()
                        .code(status.value())
                        .message(e.getMessage())
                        .build()
        );
    }

    @ExceptionHandler(value = { PasswordMatchException.class, ResourceViolationException.class })
    public ResponseEntity<GenericResponse> handlePasswordMatchException(Exception e) {
        final HttpStatus status = HttpStatus.BAD_REQUEST;
        return ResponseEntity
                .status(status)
                .body(GenericResponse.builder()
                        .code(status.value())
                        .message(e.getMessage())
                        .build()
        );
    }

    @ExceptionHandler(value = AuthenticationException.class)
    public ResponseEntity<GenericResponse> handleAuthenticationException(Exception e) {
        final HttpStatus status = HttpStatus.UNAUTHORIZED;
        return ResponseEntity
                .status(status)
                .body(GenericResponse.builder()
                        .code(status.value())
                        .message(e.getMessage())
                        .build()
        );
    }
}

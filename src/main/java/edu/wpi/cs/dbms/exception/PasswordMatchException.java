package edu.wpi.cs.dbms.exception;

public class PasswordMatchException extends RuntimeException {

    public PasswordMatchException(String message) {
        super(message);
    }
}

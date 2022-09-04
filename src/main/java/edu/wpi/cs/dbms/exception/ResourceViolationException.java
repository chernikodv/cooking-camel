package edu.wpi.cs.dbms.exception;

public class ResourceViolationException extends RuntimeException {

    private static final long serialVersionUID = -3123610141321056346L;

    public ResourceViolationException(String message) {
        super(message);
    }
}

package edu.wpi.cs.dbms.exception;

public class PasswordMatchException extends RuntimeException {

    private static final long serialVersionUID = 7148493268996838460L;

    public PasswordMatchException(String message) {
        super(message);
    }
}

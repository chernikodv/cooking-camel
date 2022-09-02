package edu.wpi.cs.dbms.domain.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class GenericResponse {
    Integer code;
    String message;
}

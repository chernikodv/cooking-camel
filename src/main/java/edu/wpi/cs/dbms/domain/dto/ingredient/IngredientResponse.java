package edu.wpi.cs.dbms.domain.dto.ingredient;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class IngredientResponse {
    Long id;
    String name;
}

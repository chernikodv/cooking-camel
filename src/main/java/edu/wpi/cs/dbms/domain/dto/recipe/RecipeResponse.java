package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class RecipeResponse {
    Long id;
    String title;
    Boolean favorite;
    String directions;
    String ownerUsername;
    String detailedIngredients;
}
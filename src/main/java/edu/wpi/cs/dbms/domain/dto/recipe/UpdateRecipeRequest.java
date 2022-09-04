package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Value;

import java.util.List;

@Value
public class UpdateRecipeRequest {
    Long id;
    String title;
    String directions;
    String detailedIngredients;
    List<Long> ingredientIds;
}

package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Value;

import java.util.List;

@Value
public class CreateRecipeRequest {
    String title;
    String directions;
    String detailedIngredients;
    List<Long> ingredientIds;
}

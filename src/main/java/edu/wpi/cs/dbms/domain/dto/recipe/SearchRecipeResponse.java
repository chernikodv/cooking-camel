package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class SearchRecipeResponse {
    Long id;
    String title;
    String directions;
    String ownerUsername;
    Boolean favorite;
    String detailedIngredients;
    Integer realIngredientsAmount;
    Integer relevantIngredientsAmount;

    public double findRelevance() {
        return (double) realIngredientsAmount / relevantIngredientsAmount;
    }
}

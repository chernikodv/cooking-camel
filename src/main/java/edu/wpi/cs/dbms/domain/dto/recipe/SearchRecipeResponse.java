package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class SearchRecipeResponse {
    Long id;
    String title;
    Boolean favorite;
    String directions;
    String ownerUsername;
    String detailedIngredients;
    Integer realIngredientsAmount;
    Integer relevantIngredientsAmount;

    public double findRelevance() {
        return (double) realIngredientsAmount / relevantIngredientsAmount;
    }
}

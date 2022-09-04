package edu.wpi.cs.dbms.mapper;

import edu.wpi.cs.dbms.domain.dto.recipe.RecipeResponse;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipe;
import org.springframework.stereotype.Component;

@Component
public class UserFavoriteRecipeMapper {

    public RecipeResponse mapEntityToRecipeResponse(UserFavoriteRecipe userFavoriteRecipe) {
        final Recipe recipe = userFavoriteRecipe.getRecipe();
        final User owner = recipe.getOwner();

        return RecipeResponse.builder()
                .favorite(true)
                .id(recipe.getId())
                .title(recipe.getTitle())
                .directions(recipe.getDirections())
                .ownerUsername(owner.getUsername())
                .detailedIngredients(recipe.getDetailedIngredients())
                .build();
    }
}

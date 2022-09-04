package edu.wpi.cs.dbms.mapper;

import edu.wpi.cs.dbms.domain.dto.recipe.CreateRecipeRequest;
import edu.wpi.cs.dbms.domain.dto.recipe.RecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.SearchRecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.UpdateRecipeRequest;
import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class RecipeMapper {

    public RecipeResponse mapEntityToResponse(Recipe recipe,
                                              Set<Recipe> favoriteRecipes) {
        final User owner = recipe.getOwner();
        return RecipeResponse.builder()
                .id(recipe.getId())
                .title(recipe.getTitle())
                .directions(recipe.getDirections())
                .ownerUsername(owner.getUsername())
                .favorite(favoriteRecipes.contains(recipe))
                .detailedIngredients(recipe.getDetailedIngredients())
                .build();
    }

    public SearchRecipeResponse mapEntityToSearchResponse(Recipe recipe,
                                                          Set<Recipe> favoriteRecipes,
                                                          List<Ingredient> ingredientByIds) {
        final User owner = recipe.getOwner();
        final List<Ingredient> realIngredients = recipe.getIngredients();
        final List<Ingredient> relevantIngredients = ingredientByIds.stream()
                .filter(realIngredients::contains)
                .collect(Collectors.toList());

        return SearchRecipeResponse.builder()
                .id(recipe.getId())
                .title(recipe.getTitle())
                .directions(recipe.getDirections())
                .ownerUsername(owner.getUsername())
                .favorite(favoriteRecipes.contains(recipe))
                .realIngredientsAmount(realIngredients.size())
                .detailedIngredients(recipe.getDetailedIngredients())
                .relevantIngredientsAmount(relevantIngredients.size())
                .build();
    }

    public Recipe mapCreateRequestToEntity(CreateRecipeRequest recipeRequest) {
        final Recipe recipe = new Recipe();
        recipe.setTitle(recipeRequest.getTitle());
        recipe.setDirections(recipeRequest.getDirections());
        recipe.setDetailedIngredients(recipeRequest.getDetailedIngredients());

        return recipe;
    }

    public Recipe mapUpdateRequestToExistingEntity(Recipe recipe,
                                                   UpdateRecipeRequest updateRecipeRequest) {
        recipe.getIngredients().clear();
        recipe.setTitle(updateRecipeRequest.getTitle());
        recipe.setDirections(updateRecipeRequest.getDirections());
        recipe.setDetailedIngredients(updateRecipeRequest.getDetailedIngredients());

        return recipe;
    }
}

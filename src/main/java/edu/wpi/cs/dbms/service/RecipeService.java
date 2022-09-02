package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.GenericResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.*;
import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.exception.DeleteResourceException;
import edu.wpi.cs.dbms.mapper.RecipeMapper;
import edu.wpi.cs.dbms.repository.IngredientRepository;
import edu.wpi.cs.dbms.repository.RecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecipeService {

    private final UserService userService;
    private final RecipeMapper recipeMapper;
    private final FavoriteService favoriteService;
    private final RecipeRepository recipeRepository;
    private final IngredientRepository ingredientRepository;
    private final AuthenticationTokenInfoExtractor tokenInfoExtractor;

    public List<SearchRecipeResponse> find(List<Long> ingredientIds, Integer page, Integer size) {
        final List<Ingredient> ingredients = ingredientRepository.findAllById(ingredientIds);
        final List<Recipe> recipes = recipeRepository.findAllByIngredientsIn(ingredients);
        final User user = userService.findById(tokenInfoExtractor.getUsername());

        return recipes.stream()
                .distinct()
                .map(recipe -> recipeMapper.mapEntityToSearchResponse(recipe, ingredients, user))
                .sorted(Comparator.comparingDouble(SearchRecipeResponse::findRelevance)
                        .thenComparing(SearchRecipeResponse::getTitle)
                )
                .skip((long) page * size)
                .limit(size)
                .collect(Collectors.toList());
    }

    public RecipeResponse findRecipeById(Long ingredientId) {
        final Optional<Recipe> maybeRecipe = recipeRepository.findById(ingredientId);
        if (maybeRecipe.isEmpty()) {
            throw new NoSuchElementException("Could not find a recipe by the given id ...");
        }

        final User user = userService.findById(tokenInfoExtractor.getUsername());
        return recipeMapper.mapEntityToResponse(maybeRecipe.get(), user);
    }

    public RecipeResponse create(CreateRecipeRequest createRecipeRequest) {
        final Recipe recipe = recipeMapper.mapCreateRequestToEntity(createRecipeRequest);
        final User owner = userService.findById(tokenInfoExtractor.getUsername());
        recipe.setOwner(owner);

        final List<Ingredient> ingredients = ingredientRepository.findAllById(createRecipeRequest.getIngredientIds());
        recipe.getIngredients().addAll(ingredients);

        final Recipe savedRecipe = recipeRepository.save(recipe);
        return recipeMapper.mapEntityToResponse(savedRecipe, owner);
    }

    public RecipeResponse update(Long id, UpdateRecipeRequest updateRecipeRequest) {
        final User user = userService.findById(tokenInfoExtractor.getUsername());
        final Recipe recipe = recipeMapper.mapUpdateRequestToExistingEntity(updateRecipeRequest, findById(id));

        final List<Ingredient> ingredients = ingredientRepository.findAllById(updateRecipeRequest.getIngredientIds());
        recipe.getIngredients().addAll(ingredients);

        final Recipe updatedRecipe = recipeRepository.save(recipe);
        return recipeMapper.mapEntityToResponse(updatedRecipe, user);
    }

    public List<RecipeResponse> findFavorites(Integer page, Integer size) {
        final User user = userService.findById(tokenInfoExtractor.getUsername());
        final Page<Recipe> recipes = recipeRepository.findAllByUsersIn(
                List.of(user),
                PageRequest.of(page, size)
        );

        return recipes.stream()
                .map(recipe -> recipeMapper.mapEntityToResponse(recipe, user))
                .collect(Collectors.toList());
    }

    public RecipeResponse addFavorite(Long id) {
        final Recipe recipe = findById(id);
        final User user = userService.findById(tokenInfoExtractor.getUsername());

        recipe.getUsers().add(user);
        final Recipe savedRecipe = recipeRepository.save(recipe);

        return recipeMapper.mapEntityToResponse(savedRecipe, user);
    }

    public RecipeResponse removeFavorite(Long id) {
        final Recipe recipe = findById(id);
        final User user = userService.findById(tokenInfoExtractor.getUsername());

        recipe.getUsers().remove(user);
        final Recipe savedRecipe = recipeRepository.save(recipe);

        return recipeMapper.mapEntityToResponse(savedRecipe, user);
    }

    public List<RecipeResponse> findTrending(Integer page, Integer size) {
        final User user = userService.findById(tokenInfoExtractor.getUsername());
        final List<String> trendingRecipeTitles = favoriteService.findTrendingRecipeTitles(page, size);
        return trendingRecipeTitles.stream()
                .map(this::findByTitle)
                .map(recipe -> recipeMapper.mapEntityToResponse(recipe, user))
                .collect(Collectors.toList());
    }

    public ResponseEntity<GenericResponse> delete(Long id) {
        final Recipe recipe = findById(id);
        recipe.getUsers().clear();

        try {
            recipeRepository.delete(recipe);
        } catch (Exception e) {
            throw new DeleteResourceException("Could not delete a recipe by the given id ...");
        }

        return ResponseEntity.ok(GenericResponse.builder()
                .code(HttpStatus.OK.value())
                .message("Recipe successfully deleted ...")
                .build()
        );
    }

    private Recipe findById(Long id) {
        final Optional<Recipe> maybeRecipe = recipeRepository.findById(id);
        return maybeRecipe.orElseThrow(() -> new NoSuchElementException("Could not find a recipe by the given id ..."));
    }

    private Recipe findByTitle(String title) {
        final Optional<Recipe> maybeRecipe = recipeRepository.findByTitle(title);
        return maybeRecipe.orElseThrow(() -> new NoSuchElementException("Could not find a recipe by the given title ..."));
    }
}

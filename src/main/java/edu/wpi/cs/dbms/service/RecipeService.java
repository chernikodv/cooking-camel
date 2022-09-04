package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.GenericResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.CreateRecipeRequest;
import edu.wpi.cs.dbms.domain.dto.recipe.RecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.SearchRecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import edu.wpi.cs.dbms.domain.dto.recipe.UpdateRecipeRequest;
import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipe;
import edu.wpi.cs.dbms.exception.ResourceViolationException;
import edu.wpi.cs.dbms.mapper.RecipeMapper;
import edu.wpi.cs.dbms.mapper.UserFavoriteRecipeMapper;
import edu.wpi.cs.dbms.repository.IngredientRepository;
import edu.wpi.cs.dbms.repository.RecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecipeService {

    private final UserService userService;
    private final RecipeMapper recipeMapper;
    private final RecipeRepository recipeRepository;
    private final IngredientRepository ingredientRepository;
    private final UserFavoriteRecipeMapper userFavoriteRecipeMapper;
    private final UserFavoriteRecipeService userFavoriteRecipeService;

    public List<SearchRecipeResponse> find(Integer page, Integer size, List<Long> ingredientIds) {
        final List<Ingredient> ingredients = ingredientRepository.findAllById(ingredientIds);
        final Page<Recipe> recipes = recipeRepository.findAllByIngredientsIn(ingredients, PageRequest.of(page, size));
        final Set<Recipe> favoriteRecipes = findFavorite();

        return recipes.stream()
                .map(recipe -> recipeMapper.mapEntityToSearchResponse(recipe, favoriteRecipes, ingredients))
                .collect(Collectors.toList());
    }

    public RecipeResponse create(CreateRecipeRequest createRecipeRequest) {
        final Recipe recipe = recipeMapper.mapCreateRequestToEntity(createRecipeRequest);
        final User owner = userService.findAuthenticatedUser();
        recipe.setOwner(owner);

        final List<Ingredient> ingredients = ingredientRepository.findAllById(createRecipeRequest.getIngredientIds());
        recipe.getIngredients().addAll(ingredients);

        final Recipe savedRecipe = recipeRepository.save(recipe);
        return recipeMapper.mapEntityToResponse(savedRecipe, Set.of());
    }

    public RecipeResponse update(UpdateRecipeRequest updateRecipeRequest) {
        final User user = userService.findAuthenticatedUser();
        final Recipe recipe = findById(updateRecipeRequest.getId());

        if (!user.equals(recipe.getOwner())) {
            throw new ResourceViolationException("Could not update not your recipe ...");
        }

        final Recipe mappedRecipe = recipeMapper.mapUpdateRequestToExistingEntity(recipe, updateRecipeRequest);
        final List<Ingredient> ingredients = ingredientRepository.findAllById(updateRecipeRequest.getIngredientIds());
        mappedRecipe.getIngredients().addAll(ingredients);

        final Set<Recipe> favoriteRecipes = findFavorite();
        final Recipe updatedRecipe = recipeRepository.save(mappedRecipe);
        return recipeMapper.mapEntityToResponse(updatedRecipe, favoriteRecipes);
    }

    public List<RecipeResponse> findFavorites(Integer page, Integer size) {
        final Page<UserFavoriteRecipe> favoriteRecipes = userFavoriteRecipeService.findFavoriteRecipes(page, size);
        return favoriteRecipes.stream()
                .map(userFavoriteRecipeMapper::mapEntityToRecipeResponse)
                .collect(Collectors.toList());
    }

    public RecipeResponse addFavorite(Long id) {
        final Recipe recipe = findById(id);
        final User user = userService.findAuthenticatedUser();
        final UserFavoriteRecipe savedUserFavoriteRecipe = userFavoriteRecipeService.save(user, recipe);

        return userFavoriteRecipeMapper.mapEntityToRecipeResponse(savedUserFavoriteRecipe);
    }

    public GenericResponse removeFavorite(Long id) {
        final Recipe recipe = findById(id);
        final User user = userService.findAuthenticatedUser();
        userFavoriteRecipeService.remove(user, recipe);

        return GenericResponse.builder()
                .code(HttpStatus.OK.value())
                .message("Favorite recipe successfully deleted ...")
                .build();
    }

    public List<RecipeResponse> findTrending(Integer page, Integer size) {
        final List<Recipe> trendingRecipes = findTrendingByTrendingRecipeIds(page, size);
        final Map<Long, RecipeResponse> idToResponse = createIdToResponseMap(trendingRecipes);

        return trendingRecipes.stream()
                .map(trendingRecipe -> idToResponse.get(trendingRecipe.getId()))
                .collect(Collectors.toList());
    }

    private Recipe findById(Long id) {
        final Optional<Recipe> maybeRecipe = recipeRepository.findById(id);
        return maybeRecipe.orElseThrow(() -> new NoSuchElementException("Could not find a recipe by the given id ..."));
    }

    private List<Recipe> findTrendingByTrendingRecipeIds(Integer page, Integer size) {
        final List<Long> trendingRecipeIds = userFavoriteRecipeService.findTrendingRecipes(page, size)
                .stream()
                .map(TrendingRecipe::getId)
                .collect(Collectors.toList());
        return recipeRepository.findAllById(trendingRecipeIds);
    }

    private Set<Recipe> findFavorite() {
        final Page<UserFavoriteRecipe> recipes = userFavoriteRecipeService.findFavoriteRecipes(0, Integer.MAX_VALUE);
        return recipes.stream()
                .map(UserFavoriteRecipe::getRecipe)
                .collect(Collectors.toSet());
    }

    private Map<Long, RecipeResponse> createIdToResponseMap(List<Recipe> trendingRecipes) {
        final Set<Recipe> favoriteRecipes = findFavorite();
        return trendingRecipes.stream()
                .map(recipe -> recipeMapper.mapEntityToResponse(recipe, favoriteRecipes))
                .collect(
                        Collectors.toMap(
                                RecipeResponse::getId,
                                recipeResponse -> recipeResponse
                        )
                );
    }
}

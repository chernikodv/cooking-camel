package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.GenericResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.CreateRecipeRequest;
import edu.wpi.cs.dbms.domain.dto.recipe.RecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.SearchRecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.UpdateRecipeRequest;
import edu.wpi.cs.dbms.service.RecipeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000/")
@RequestMapping(path = "/api/recipes")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping
    public List<SearchRecipeResponse> find(@RequestParam List<Long> ingredientsId,
                                           @RequestParam(defaultValue = "0") Integer page,
                                           @RequestParam(defaultValue = "10", required = false) Integer size) {
        return recipeService.find(ingredientsId, page, size);
    }

    @GetMapping(path = "/recipe")
    public RecipeResponse find(Long ingredientId)  {
        return recipeService.findRecipeById(ingredientId);
    }

    @PostMapping
    public RecipeResponse create(@RequestBody CreateRecipeRequest recipeRequest) {
        return recipeService.create(recipeRequest);
    }

    @PutMapping(path = "/{id}")
    public RecipeResponse update(@PathVariable Long id, @RequestBody UpdateRecipeRequest recipeRequest) {
        return recipeService.update(id, recipeRequest);
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<GenericResponse> delete(@PathVariable Long id) {
        return recipeService.delete(id);
    }

    @GetMapping(path = "/favorites")
    public List<RecipeResponse> findFavorites(@RequestParam(defaultValue = "0") Integer page,
                                              @RequestParam(defaultValue = "10", required = false) Integer size) {
        return recipeService.findFavorites(page, size);
    }

    @PostMapping(path = "/favorites/{id}")
    public RecipeResponse addFavorite(@PathVariable Long id) {
        return recipeService.addFavorite(id);
    }

    @DeleteMapping(path = "/favorites/{id}")
    public RecipeResponse removeFavorite(@PathVariable Long id) {
        return recipeService.removeFavorite(id);
    }

    @GetMapping(path = "/trending")
    public List<RecipeResponse> findTrending(@RequestParam(defaultValue = "0", required = false) Integer page,
                                             @RequestParam(defaultValue = "10", required = false) Integer size) {
        return recipeService.findTrending(page, size);
    }
}

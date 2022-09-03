package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.GenericResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.CreateRecipeRequest;
import edu.wpi.cs.dbms.domain.dto.recipe.RecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.SearchRecipeResponse;
import edu.wpi.cs.dbms.domain.dto.recipe.UpdateRecipeRequest;
import edu.wpi.cs.dbms.service.RecipeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/api/recipes")
@CrossOrigin(origins = "http://localhost:3000/")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping
    public List<SearchRecipeResponse> find(@RequestParam List<Long> ingredientsId,
                                           @RequestParam(defaultValue = "0") Integer page,
                                           @RequestParam(defaultValue = "10", required = false) Integer size) {
        return recipeService.find(page, size, ingredientsId);
    }

    @PostMapping
    public RecipeResponse create(@RequestBody CreateRecipeRequest recipeRequest) {
        return recipeService.create(recipeRequest);
    }

    // TODO: add id to request
    @PutMapping(path = "/{id}")
    public RecipeResponse update(@PathVariable Long id, @RequestBody UpdateRecipeRequest recipeRequest) {
        return recipeService.update(id, recipeRequest);
    }
//
//    @DeleteMapping(path = "/{id}")
//    public ResponseEntity<GenericResponse> delete(@PathVariable Long id) {
//        return recipeService.delete(id);
//    }

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
    public GenericResponse removeFavorite(@PathVariable Long id) {
        return recipeService.removeFavorite(id);
    }

    @GetMapping(path = "/trending")
    public List<RecipeResponse> findTrending(@RequestParam(defaultValue = "0", required = false) Integer page,
                                             @RequestParam(defaultValue = "10", required = false) Integer size) {
        return recipeService.findTrending(page, size);
    }
}

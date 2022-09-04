package edu.wpi.cs.dbms.controller;

import edu.wpi.cs.dbms.domain.dto.ingredient.CreateIngredientRequest;
import edu.wpi.cs.dbms.domain.dto.ingredient.IngredientResponse;
import edu.wpi.cs.dbms.service.IngredientService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/api/ingredients")
@CrossOrigin(origins = "http://localhost:3000/")
public class IngredientController {

    private final IngredientService ingredientService;

    @PostMapping
    public IngredientResponse create(@RequestBody CreateIngredientRequest createIngredientRequest) {
        return ingredientService.create(createIngredientRequest);
    }

    @GetMapping
    public List<IngredientResponse> findByNameLike(@RequestParam(required = false) String name,
                                                   @RequestParam(defaultValue = "0") Integer page,
                                                   @RequestParam(defaultValue = "10", required = false) Integer size) {
        return ingredientService.find(name, page, size);
    }
}

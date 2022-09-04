package edu.wpi.cs.dbms.service;

import edu.wpi.cs.dbms.domain.dto.ingredient.CreateIngredientRequest;
import edu.wpi.cs.dbms.domain.dto.ingredient.IngredientResponse;
import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.mapper.IngredientMapper;
import edu.wpi.cs.dbms.repository.IngredientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class IngredientService {

    private final IngredientMapper ingredientMapper;
    private final IngredientRepository ingredientRepository;

    public IngredientResponse create(CreateIngredientRequest createIngredientRequest) {
        final Ingredient ingredient = ingredientMapper.mapCreateRequestToEntity(createIngredientRequest);
        final Ingredient savedIngredient = ingredientRepository.save(ingredient);
        return ingredientMapper.mapEntityToResponse(savedIngredient);
    }

    public List<IngredientResponse> find(String name, Integer page, Integer size) {
        final Page<Ingredient> ingredients;

        if (name == null || name.isBlank()) {
            ingredients = ingredientRepository.findAll(PageRequest.of(page, size));
        } else {
            ingredients = ingredientRepository.findAllByNameLike(name, PageRequest.of(page, size));
        }

        return ingredients.stream()
                .map(ingredientMapper::mapEntityToResponse)
                .collect(Collectors.toList());
    }
}

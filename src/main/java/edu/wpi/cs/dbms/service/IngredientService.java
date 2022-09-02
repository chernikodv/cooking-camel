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

import javax.persistence.criteria.CriteriaBuilder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
        Set<IngredientResponse> ingredientResponses = new HashSet<>();
        final Page<Ingredient> ingredients;

        if (name == null || name.isBlank()) {
            ingredients = ingredientRepository.findAll(PageRequest.of(page, size));
            ingredientResponses.addAll(getIngredientResponseFromPage(ingredients));
        } else {
            final String pattern = name;
            final Page<Ingredient> exactMatch = ingredientRepository.findAllByNameLike(pattern, PageRequest.of(page, size));
            ingredientResponses.addAll(getIngredientResponseFromPage(exactMatch));
            final Page<Ingredient> allMatches = ingredientRepository.findAllByNameLike(pattern + "%", PageRequest.of(page, size-1));
            ingredientResponses.addAll(getIngredientResponseFromPage(allMatches));

        }

        return new ArrayList<>(ingredientResponses);
    }

    private List<IngredientResponse> getIngredientResponseFromPage(Page<Ingredient> ingredients){
        return ingredients.stream()
                .map(ingredientMapper::mapEntityToResponse)
                .collect(Collectors.toList());
    }
}

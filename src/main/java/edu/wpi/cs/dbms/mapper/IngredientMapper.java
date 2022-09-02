package edu.wpi.cs.dbms.mapper;

import edu.wpi.cs.dbms.domain.dto.ingredient.CreateIngredientRequest;
import edu.wpi.cs.dbms.domain.dto.ingredient.IngredientResponse;
import edu.wpi.cs.dbms.domain.entity.Ingredient;
import org.springframework.stereotype.Component;

@Component
public class IngredientMapper {

    public IngredientResponse mapEntityToResponse(Ingredient ingredient){
        return IngredientResponse.builder()
                .id(ingredient.getId())
                .name(ingredient.getName())
                .build();

    }

    public Ingredient mapCreateRequestToEntity(CreateIngredientRequest createIngredientRequest) {
        final Ingredient ingredient = new Ingredient();
        ingredient.setName(createIngredientRequest.getName());

        return ingredient;
    }
}

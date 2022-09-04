package edu.wpi.cs.dbms.domain.dto.recipe;

import lombok.Value;

@Value
public class TrendingRecipe {
    Long id;
    Integer count;
}

package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipe;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipeId;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import java.time.LocalDateTime;
import java.util.List;

@org.springframework.stereotype.Repository
public interface UserFavoriteRecipeRepository extends Repository<UserFavoriteRecipe, UserFavoriteRecipeId> {

    @Query(name = "findTrendingRecipes", nativeQuery = true)
    List<TrendingRecipe> findTrendingRecipes(LocalDateTime start, LocalDateTime end, Pageable pageable);
}

package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import edu.wpi.cs.dbms.domain.entity.User;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipe;
import edu.wpi.cs.dbms.domain.entity.UserFavoriteRecipeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface UserFavoriteRecipeRepository extends JpaRepository<UserFavoriteRecipe, UserFavoriteRecipeId> {

    @EntityGraph(attributePaths = {"recipe"})
    Page<UserFavoriteRecipe> findAllByUserOrderByLikedOnAsc(User user, Pageable pageable);

    @Query(name = "findTrendingRecipes", nativeQuery = true)
    List<TrendingRecipe> findTrendingRecipes(LocalDateTime start, LocalDateTime end, Pageable pageable);
}

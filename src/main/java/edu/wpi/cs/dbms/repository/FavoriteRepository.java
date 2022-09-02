package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.Favorite;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FavoriteRepository extends JpaRepository<Favorite, String> {

    @Query("SELECT recipeTitle FROM Favorite GROUP BY recipeTitle ORDER BY COUNT(recipeTitle) DESC")
    List<String> groupByRecipeTitle(Pageable pageable);
}

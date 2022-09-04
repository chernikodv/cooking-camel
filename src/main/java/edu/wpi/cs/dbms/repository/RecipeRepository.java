package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {

    @EntityGraph(attributePaths = {"ingredients"})
    Page<Recipe> findAllByIngredientsIn(Iterable<Ingredient> ingredients, Pageable pageable);
}

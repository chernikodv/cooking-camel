package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {

    // TODO: try eager loading of owner without entity graph
    @Override
    @EntityGraph(attributePaths = {"owner"})
    Optional<Recipe> findById(Long id);

    @Override
    @EntityGraph(attributePaths = {"owner"})
    List<Recipe> findAllById(Iterable<Long> ids);

    @EntityGraph(attributePaths = {"ingredients"})
    List<Recipe> findAllByIngredientsIn(List<Ingredient> ingredients);
}

package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.Ingredient;
import edu.wpi.cs.dbms.domain.entity.Recipe;
import edu.wpi.cs.dbms.domain.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {
    @Override
    @EntityGraph(attributePaths = {"users"})
    Optional<Recipe> findById(Long id);

    @Override
    @EntityGraph(attributePaths = {"users"})
    Page<Recipe> findAll(Pageable pageable);

    @EntityGraph(attributePaths = {"users"})
    Page<Recipe> findAllByUsersIn(List<User> users, Pageable pageable);

    @EntityGraph(attributePaths = {"users"})
    List<Recipe> findAllByIngredientsIn(List<Ingredient> ingredients);

    @EntityGraph(attributePaths = {"users"})
    Optional<Recipe> findByTitle(String title);
}

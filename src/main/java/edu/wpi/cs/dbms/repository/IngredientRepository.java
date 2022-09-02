package edu.wpi.cs.dbms.repository;

import edu.wpi.cs.dbms.domain.entity.Ingredient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IngredientRepository extends JpaRepository<Ingredient, Long> {
    Page<Ingredient> findAllByNameLike(String name, Pageable page);
}

package edu.wpi.cs.dbms.domain.entity;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(schema = "cooking_camel_schema", name = "user_favorite_recipe")
@NamedNativeQuery(
        name = "findTrendingRecipes",
        query = "SELECT recipe_id AS id, COUNT(*) AS count " +
                "FROM cooking_camel_schema.user_favorite_recipe " +
                "WHERE liked_on >= :start AND liked_on <= :end " +
                "GROUP BY recipe_id " +
                "ORDER BY count DESC",
        resultSetMapping = "TrendingRecipe"
)
@SqlResultSetMapping(
        name="TrendingRecipe",
        classes = {
                @ConstructorResult(
                        targetClass = TrendingRecipe.class,
                        columns = {
                                @ColumnResult(name = "id", type = Long.class),
                                @ColumnResult(name = "count", type = Integer.class)
                        })
        }
)
public class UserFavoriteRecipe {

    @EmbeddedId
    private UserFavoriteRecipeId id;

    @ManyToOne
    @MapsId(value = "username")
    @JoinColumn(name = "username", referencedColumnName = "username")
    private User user;

    @ManyToOne
    @MapsId(value = "recipeId")
    @JoinColumn(name = "recipe_id", referencedColumnName = "id")
    private Recipe recipe;

    @Column(name = "liked_on")
    private LocalDateTime likedOn;
}

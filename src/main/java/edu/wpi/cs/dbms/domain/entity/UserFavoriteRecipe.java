package edu.wpi.cs.dbms.domain.entity;

import edu.wpi.cs.dbms.domain.dto.recipe.TrendingRecipe;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@ToString
@EqualsAndHashCode(of = "id")
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

    @ToString.Exclude
    @MapsId(value = "username")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "username")
    private User user;

    @ToString.Exclude
    @MapsId(value = "recipeId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id", referencedColumnName = "id")
    private Recipe recipe;

    private LocalDateTime likedOn;
}

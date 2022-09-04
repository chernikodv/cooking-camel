package edu.wpi.cs.dbms.domain.entity;

import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Setter
@Embeddable
@NoArgsConstructor
public class UserFavoriteRecipeId implements Serializable {

    private static final long serialVersionUID = 6586907195498971944L;

    @Column(name = "username")
    private String username;

    @Column(name = "recipe_id")
    private Long recipeId;
}

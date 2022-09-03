package edu.wpi.cs.dbms.domain.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class UserFavoriteRecipeId implements Serializable {

    private static final long serialVersionUID = 6586907195498971944L;

    @Column(name = "username")
    private String username;

    @Column(name = "recipe_id")
    private Long recipeId;
}

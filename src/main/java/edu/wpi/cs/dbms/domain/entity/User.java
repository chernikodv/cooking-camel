package edu.wpi.cs.dbms.domain.entity;

import lombok.Data;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(schema = "cooking_camel_schema", name = "user")
public class User {

    @Id
    private String username;

    private String email;

    private Boolean administrator;

    private String password;

    private String firstName;

    private String lastName;

    @ToString.Exclude
    @OneToMany(mappedBy = "owner")
    private List<Recipe> createdRecipes = new ArrayList<>();

    @ToString.Exclude
    @ManyToMany(mappedBy = "users")
    private List<Recipe> favoriteRecipes = new ArrayList<>();
}

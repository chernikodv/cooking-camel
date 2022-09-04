package edu.wpi.cs.dbms.domain.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@EqualsAndHashCode(of = "username")
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
}

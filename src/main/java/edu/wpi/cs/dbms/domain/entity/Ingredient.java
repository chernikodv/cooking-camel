package edu.wpi.cs.dbms.domain.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Data
@Entity
@Table(schema = "cooking_camel_schema", name = "ingredient")
public class Ingredient {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ingredient_id_seq_gen")
    @SequenceGenerator(name = "ingredient_id_seq_gen", sequenceName = "ingredient_id_seq", schema = "cooking_camel_schema", allocationSize = 1)
    private Long id;

    private String name;
}

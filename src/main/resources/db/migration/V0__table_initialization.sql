CREATE SCHEMA IF NOT EXISTS cooking_camel_schema;

SET search_path TO cooking_camel_schema;

BEGIN;

CREATE TABLE IF NOT EXISTS "user" (
    username TEXT PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    administrator BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS "recipe" (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    directions TEXT NOT NULL,
    detailed_ingredients TEXT NOT NULL,
    owner_username TEXT REFERENCES "user"(username)
);

CREATE TABLE IF NOT EXISTS "ingredient" (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "recipe_ingredient" (
    recipe_id INTEGER REFERENCES recipe(id),
    ingredient_id INTEGER REFERENCES ingredient(id),
    PRIMARY KEY(recipe_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS "user_favorite_recipe" (
    username TEXT REFERENCES "user"(username),
    recipe_id INTEGER REFERENCES recipe(id),
    liked_on TIMESTAMP NOT NULL,
    PRIMARY KEY(username, recipe_id)
);

COMMIT;
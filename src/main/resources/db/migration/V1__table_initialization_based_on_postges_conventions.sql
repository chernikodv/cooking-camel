-- Never ever change a migration script, if it has been committed to the main branch.
-- If you want to change something in a previous script, create another migration script, and alter whatever you want.
SET SEARCH_PATH TO cooking_camel_schema;

BEGIN;

DROP TABLE IF EXISTS RecipeIngredients;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Favorites;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Users;

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
    PRIMARY KEY(username, recipe_id)
);

COMMIT;
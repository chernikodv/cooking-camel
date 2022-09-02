-- Migration with trigger 'getRecipeTitle' and the function 'insert_recipe_title()'

SET SEARCH_PATH TO cooking_camel_schema;

BEGIN;

CREATE TABLE IF NOT EXISTS "favorite" (
    id SERIAL PRIMARY KEY,
    recipe_title TEXT NOT NULL
);

CREATE OR REPLACE FUNCTION insert_recipe_title()
    RETURNS trigger AS
$BODY$
DECLARE
    recipe_title TEXT;
BEGIN
    SELECT title INTO recipe_title
    FROM cooking_camel_schema.recipe
    WHERE id = NEW.recipe_id;

    INSERT INTO cooking_camel_schema.favorite (id, recipe_title)
    VALUES (DEFAULT, recipe_title);

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER insert_recipe_title
    AFTER INSERT
    ON user_favorite_recipe
    FOR EACH ROW
EXECUTE PROCEDURE insert_recipe_title();

CREATE OR REPLACE FUNCTION remove_recipe_title()
    RETURNS trigger AS
$BODY$
DECLARE
    favorite_id INTEGER;
BEGIN
    SELECT max(id) INTO favorite_id
    FROM cooking_camel_schema.favorite
    WHERE recipe_title = (
        SELECT title
        FROM cooking_camel_schema.recipe
        WHERE id = OLD.recipe_id
    );

    DELETE FROM cooking_camel_schema.favorite
    WHERE id = favorite_id;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER remove_recipe_title
    AFTER DELETE
    ON user_favorite_recipe
    FOR EACH ROW
EXECUTE PROCEDURE remove_recipe_title();

COMMIT;

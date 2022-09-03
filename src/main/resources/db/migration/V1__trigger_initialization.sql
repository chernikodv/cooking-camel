SET search_path TO cooking_camel_schema;

BEGIN;

CREATE OR REPLACE FUNCTION insert_default_owner_username()
    RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (NEW.owner_username IS NULL) THEN
        NEW.owner_username = 'admin';
    END IF;

    RETURN NEW;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER recipe_default_owner_username
    BEFORE INSERT
    ON recipe
    FOR EACH ROW
EXECUTE PROCEDURE insert_default_owner_username();

CREATE OR REPLACE FUNCTION insert_default_liked_on()
    RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (NEW.liked_on IS NULL) THEN
        NEW.liked_on = now();
    END IF;

    RETURN NEW;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER user_favorite_recipe_default_liked_on
    BEFORE INSERT
    ON user_favorite_recipe
    FOR EACH ROW
EXECUTE PROCEDURE insert_default_liked_on();

COMMIT;
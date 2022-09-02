SET SEARCH_PATH TO cooking_camel_schema;

INSERT INTO "user" (username, email, password, first_name, last_name, administrator)
VALUES
-- $2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy = encoded empty password ("")
('admin', 'admin@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'Admin', 'Admin', true),
('ngunale', 'ngunale@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'Nikhil', 'Gunale', true),
('jhiggins', 'jhiggins@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'John', 'Higgins', true),
('zahilman', 'zahilman@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'Zachary', 'Hilman', true),
('jemetcalf', 'jemetcalf@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'Jonathan', 'Metcalf', true),
('dchernikov', 'dchernikov@wpi.edu', '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy', 'Dmitriy', 'Chernikov', true);

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

COMMIT;
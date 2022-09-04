SET SEARCH_PATH TO cooking_camel_schema;

INSERT INTO "user" (username, email, password, first_name, last_name, administrator)
VALUES
-- inserted users have the same encrypted password "1234"
('admin', 'admin@wpi.edu', '$2a$10$4DA6QjB6y0iCEHinYf9DUOIb0o8g.gF91/PJ0IaBfqZzfEufBlowi', 'Admin', 'Admin', true),
('ngunale', 'ngunale@wpi.edu', '$2a$10$nmZ8HIcOPlss0byRa3fLWO.bblKxYnY6OCsf4dq7vnrq/0K.KXkou', 'Nikhil', 'Gunale', true),
('jhiggins', 'jhiggins@wpi.edu', '$2a$10$M6UEh/yfUT4qdHczggLkde6d2kTKrUGedCgObHTIUT172G3iVJ0Gi', 'John', 'Higgins', true),
('zahilman', 'zahilman@wpi.edu', '$2a$10$QJ9f9ampSnBjgA5eHV.oG.fkMFb1BIWk0cfe5Nhjv3HOe2WAf949y', 'Zachary', 'Hilman', true),
('jemetcalf', 'jemetcalf@wpi.edu', '$2a$10$UiK07zIBjVoaltI5csgsfOkfhjycN1YSI38HNCEeyDxsojsR5kCM6', 'Jonathan', 'Metcalf', true),
('dchernikov', 'dchernikov@wpi.edu', '$2a$10$aPgp0vRMM18old7LFAhCde7ghb6q5XM66Xi9Io/RX1iVO2wP2yPle', 'Dmitriy', 'Chernikov', true);

COMMIT;
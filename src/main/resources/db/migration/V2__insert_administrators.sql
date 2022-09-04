SET SEARCH_PATH TO cooking_camel_schema;

INSERT INTO "user" (username, email, password, first_name, last_name, administrator)
VALUES
-- inserted users have the same encrypted password, i.e. "1234"
('admin', 'admin@wpi.edu', '$2a$10$4DA6QjB6y0iCEHinYf9DUOIb0o8g.gF91/PJ0IaBfqZzfEufBlowi', 'Admin', 'Admin', true),
('dchernikov', 'dchernikov@wpi.edu', '$2a$10$aPgp0vRMM18old7LFAhCde7ghb6q5XM66Xi9Io/RX1iVO2wP2yPle', 'Dmitriy', 'Chernikov', true);

COMMIT;
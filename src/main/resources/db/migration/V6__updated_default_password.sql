SET SEARCH_PATH TO cooking_camel_schema;

BEGIN;

-- new password is encoded "1234"
UPDATE "user"
SET password = '$2a$10$ZicEgOqmiD.4x6CSqIl5jOSU9Q1gSPYY789/Oxmw77e4dtyCgU2ka'
WHERE password = '$2a$10$WgZbfWc5iJOtRsoEUAGIGez4eMVt/S8mBVgqKvF6hiOXJPIiaAFCy';

COMMIT;
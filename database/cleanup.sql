START TRANSACTION;

DROP TABLE IF EXISTS "employees" CASCADE;
DROP TABLE IF EXISTS "departments" CASCADE;
DROP TABLE IF EXISTS "departments_employees" CASCADE;

COMMIT;
START TRANSACTION;

CREATE OR REPLACE FUNCTION "add_department" (title varchar)
  RETURNS integer AS
$body$
  DECLARE result integer := null;
  BEGIN
    INSERT INTO "departments" (title)
    VALUES (title)
    RETURNING id INTO result;
    RETURN result;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "get_departments" ("limit" integer default null)
  RETURNS SETOF "departments" AS
  $body$
  BEGIN
    RETURN QUERY
      SELECT *
      FROM departments
      WHERE NOT is_deleted
      LIMIT "limit"
    ;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "add_employee" (title varchar)
  RETURNS integer AS
$body$
  DECLARE result integer := null;
  BEGIN
    INSERT INTO "employees" (title)
    VALUES (title)
    RETURNING id INTO result;
    RETURN result;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "add_employee_to_department" (department_id integer, employee_id integer)
  RETURNS integer AS
$body$
  DECLARE result integer := null;
  BEGIN
    INSERT INTO "departments_employees" (department_id, employee_id)
    VALUES (department_id, employee_id)
    RETURNING id INTO result;
    RETURN result;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "add_login" (login varchar, password varchar)
  RETURNS integer AS
  $body$
  DECLARE result integer := null;
    salt varchar := null;
  BEGIN
    salt = RANDOM()::varchar;
    INSERT INTO logins(login, password, salt)
      VALUES (login, md5(password||salt), salt)
    RETURNING id INTO result;
    RETURN result;
  END;
  $body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "add_employee" (title varchar, department_id integer)
  RETURNS integer AS
$body$
  DECLARE result integer := null;
    link_id integer := null;
  BEGIN
    START TRANSACTION;
      result := add_employee(title);
      link_id := add_employee_to_department(department_id, result);
      RETURN result;
    COMMIT;
  END;
$body$ LANGUAGE plpgsql;
COMMIT;

DROP FUNCTION IF EXISTS "check_and_get_login"(varchar, varchar);

CREATE OR REPLACE FUNCTION "check_and_get_login" (checked_login varchar, checked_password varchar)
  RETURNS TABLE(id int, login varchar) AS
$body$
    BEGIN
      RETURN QUERY
        SELECT l.id, l.login
        FROM logins AS l
        WHERE l."login" = checked_login
              AND l."password" = md5(checked_password||salt)
              AND NOT is_deleted
      ;
    END;
$body$ LANGUAGE plpgsql;

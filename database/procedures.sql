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

CREATE OR REPLACE FUNCTION "get_departments" ("lookup_id" integer default null, "limit" integer default null)
  RETURNS SETOF "departments" AS
  $body$
  BEGIN
    RETURN QUERY
      SELECT *
      FROM departments
      WHERE NOT is_deleted
        AND (lookup_id IS NULL OR id = lookup_id)
      ORDER BY id
      LIMIT "limit"
    ;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "get_department_employees" ("lookup_id" integer)
  RETURNS SETOF "employees" AS
  $body$
  BEGIN
    RETURN QUERY
      SELECT e.*
      FROM departments_employees AS de
        INNER JOIN employees AS e
          ON de.employee_id = e.id
      WHERE de.department_id = lookup_id
        AND NOT e.is_deleted
      ;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "get_available_for_adding_employees" ("lookup_id" integer)
  RETURNS SETOF "employees" AS
  $body$
  BEGIN
    RETURN QUERY
    WITH current_employee_ids AS (
      SELECT de.employee_id
      FROM departments_employees AS de
      WHERE de.department_id = lookup_id
    )
    SELECT e.*
    FROM employees AS e
    WHERE e.id NOT IN (SELECT employee_id FROM current_employee_ids)
      AND NOT e.is_deleted
    ;
  END;
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "edit_department" (lookup_id integer, new_title varchar)
  RETURNS integer AS
  $body$
  BEGIN
    UPDATE departments
    SET title = new_title
    WHERE id = lookup_id;
    RETURN NULL;
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

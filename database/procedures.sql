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
  BEGIN
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
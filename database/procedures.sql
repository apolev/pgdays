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
  END;
$body$ LANGUAGE plpgsql;

COMMIT;
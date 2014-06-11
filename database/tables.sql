START TRANSACTION;

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  title VARCHAR NOT NULL,
  login_id INTEGER DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT NULL
);

COMMENT ON TABLE employees             IS 'Сотрудники';
COMMENT ON COLUMN employees.id         IS 'Идентификатор сотрудника';
COMMENT ON COLUMN employees.title      IS 'Полное имя сотрудника';
COMMENT ON COLUMN employees.login_id   IS 'Привязка к логину в CRM (опционально)';
COMMENT ON COLUMN employees.created_at IS 'Дата создания';
COMMENT ON COLUMN employees.is_deleted IS 'Флаг удаления';
COMMENT ON COLUMN employees.deleted_at IS 'Дата удаления';


CREATE TABLE logins (
    id SERIAL PRIMARY KEY,
    login VARCHAR NOT NULL,
    password CHAR(32),
    salt CHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
    is_deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP
);

COMMENT ON TABLE  logins            IS 'Логины для входа в CRM';
COMMENT ON COLUMN logins.id         IS 'Идентификатор логина';
COMMENT ON COLUMN logins.login      IS 'Логин';
COMMENT ON COLUMN logins.password   IS 'Пароль';
COMMENT ON COLUMN logins.salt       IS 'Соль для хеширования пароля';
COMMENT ON COLUMN logins.created_at IS 'Дата создания логина';
COMMENT ON COLUMN logins.is_deleted IS 'Флаг удаления';
COMMENT ON COLUMN logins.deleted_at IS 'Дата удаления';


CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  title VARCHAR NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT NULL
);

COMMENT ON TABLE  departments            IS 'Отделы';
COMMENT ON COLUMN departments.id         IS 'Идентификатор отдела';
COMMENT ON COLUMN departments.title      IS 'Название отдела';
COMMENT ON COLUMN departments.created_at IS 'Дата создания отдела';
COMMENT ON COLUMN departments.is_deleted IS 'Флаг удаления';
COMMENT ON COLUMN departments.deleted_at IS 'Дата удаления';


CREATE TABLE departments_employees (
  department_id INTEGER NOT NULL,
  employee_id INTEGER NOT NULL,
  linked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);

COMMENT ON TABLE  departments_employees    IS 'Логины для входа в CRM';
COMMENT ON COLUMN departments_employees.department_id IS 'Идентификатор отдела';
COMMENT ON COLUMN departments_employees.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN departments_employees.employee_id IS 'Дата зачисления сотрудника в отдел';

COMMIT;
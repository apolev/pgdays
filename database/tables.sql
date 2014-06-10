-- Объявление таблиц для проекта.
START TRANSACTION;

-- Таблица сотрудников
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT NULL
);

-- Таблица отделов
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT NULL
);

-- Связь MxN отделов с сотрудниками
CREATE TABLE departments_employees (
  department_id INTEGER,
  employee_id INTEGER,
  linked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);

COMMIT;
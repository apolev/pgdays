-- Условия целостности
ALTER TABLE departments_employees
  ADD CONSTRAINT departments_employees_employee_id_fkey
  FOREIGN KEY (employee_id) REFERENCES employees (id)
;

ALTER TABLE departments_employees
  ADD CONSTRAINT department_employees_department_id_fkey
  FOREIGN KEY (department_id) REFERENCES departments (id)
;

CREATE UNIQUE INDEX department_employees_emp_dep_uq_idx
  ON departments_employees
  USING BTREE (department_id, employee_id)
;

CREATE UNIQUE INDEX departments_title_uq_idx
  ON departments
  USING BTREE (title) WHERE NOT is_deleted
;

CREATE UNIQUE INDEX employees_title_uq_idx
  ON employees
  USING BTREE (title) WHERE NOT is_deleted
;

CREATE UNIQUE INDEX logins_login_uq_idx
  ON logins
  USING BTREE (login) WHERE NOT is_deleted
;

-- Индексы
CREATE INDEX department_employees_employee_id_fkey_idx
  ON departments_employees
  USING BTREE (employee_id)
;

CREATE INDEX department_employees_department_id_fkey_idx
  ON departments_employees
  USING BTREE (department_id)
;

START TRANSACTION;

SELECT add_department('IT разработка');
SELECT add_department('IT администрирование');
SELECT add_department('Архитекторы');
SELECT add_department('Маркетинг');

SELECT add_employee('Иван Иванов');
SELECT add_employee('Григорий Фёдоров');
SELECT add_employee('Николай Валентинов');

SELECT add_employee_to_department(1, 1);
SELECT add_employee_to_department(1, 2);
SELECT add_employee_to_department(2, 3);
SELECT add_employee_to_department(3, 3);

SELECT add_login('pgdays', 'security');

COMMIT;
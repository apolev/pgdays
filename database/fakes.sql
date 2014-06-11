START TRANSACTION;

SELECT add_department('Разработчики');
SELECT add_department('Системные администраторы');
SELECT add_department('Архитекторы');

SELECT add_employee('Иван Иванов');
SELECT add_employee('Григорий Фёдоров');
SELECT add_employee('Николай Валентинов');

COMMIT;
START TRANSACTION;

SELECT add_department('Разработчики');
SELECT add_department('Системные администраторы');
SELECT add_department('Архитекторы');

COMMIT;
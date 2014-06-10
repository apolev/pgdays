<?php

require_once __DIR__ . '/vendor/autoload.php';

$container = new Container();
$db        = $container->getDb();
$dbDir     = __DIR__ . '/database/';

$db->execute(file_get_contents($dbDir . 'cleanup.sql'));
$db->execute(file_get_contents($dbDir . 'tables.sql'));
$db->execute(file_get_contents($dbDir . 'indexes_and_constraints.sql'));
$db->execute(file_get_contents($dbDir . 'procedures.sql'));

echo "Done\n";

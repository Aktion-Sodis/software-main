Run on Benes Mac :D:

- mysql.server start
- mysql

wenn neu initialisieren:
- CREATE DATABASE sodis_migration;
- USE sodis_migration;

-> dann gesamten sql inhalt reinpasten (siehe lib (sodis_dbv1_dump.sql))

SET PASSWORD FOR 'aktionsodis'@'localhost' = PASSWORD('platzhalter');
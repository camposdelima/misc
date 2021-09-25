@echo off
set tableName=%1
set username=%2
set password=%3
set server=%4
set database=postgres
set databasesQuery="SELECT datname FROM pg_database WHERE datistemplate = false limit 20;"
set query="select table_catalog,table_name from information_schema.tables where table_name = '%tableName%'"
set conString="postgres://%username%:%password%@%server%/%database%?sslmode=disable"
set command=usql %conString% -c %databasesQuery% -t

echo Finding table '%tableName%' at %server% with %username%...
FOR /F "skip=1" %%D IN ('%command%') DO @(
  usql postgres://%username%:%password%@%server%/%%D?sslmode=disable -c %query% -t | findstr ^|
)
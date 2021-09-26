@echo off
set tableName=%1
set username=%2
set password=%3
set server=%4
set options=sslmode=disable
set database=postgres
set limit=100
set databasesQuery="SELECT datname || ',' FROM pg_database WHERE datistemplate = false order by datname limit %limit%;"
set query="select table_catalog,table_schema, table_name from information_schema.tables where table_name = '%tableName%'"
set conString="postgres://%username%:%password%@%server%/%database%?sslmode=disable"
REM set command=usql %conString% -c %databasesQuery% -t

echo Finding table '%tableName%' at %server% with %username%...
REM for /f %%i in ('%command%') do set databases=%%i
usql %conString% -c %databasesQuery% -t > databases
REM type databases
find databases  "," /c
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "skip=1" %%D IN (databases) DO @(
  SET databaseName=%%D
  SET databaseName=!databaseName:~0,-1!
  echo Finding !databaseName!...  
  usql postgres://%username%:%password%@%server%/!databaseName!?%options% -c %query% -t | findstr ^|
)

del databases /f
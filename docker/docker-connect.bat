@echo off
REM docker-machine start %0
@FOR /f "tokens=*" %%i IN ('"C:\ProgramData\chocolatey\lib\docker-machine\bin\docker-machine.exe" env %1') DO %%i
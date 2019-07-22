@echo off
set DOCKER_HOST=tcp://%1:2376
set DOCKER_CERT_PATH=%userprofile%/.docker/machine/machines/%1
set DOCKER_TLS_VERIFY=1
set DOCKER_MACHINE_NAME=%1
docker ps
@echo off
echo Fax Services
DISM /online /disable-feature /featurename:FaxServicesClientPackage /NoRestart

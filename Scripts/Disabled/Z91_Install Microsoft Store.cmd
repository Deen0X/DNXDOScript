rem @echo off
cd /d "%~dp0"
pushd "%~dp0"
echo INSTALLING Microsoft Store
powershell -ExecutionPolicy Unrestricted Start-Process powershell -Verb "runAs .\..\..\Extras\MicrosoftStore\Add-Store.cmd"

@echo off
echo Disabling Windows Security Center
REG add "HKLM\SYSTEM\CurrentControlSet\services\wscsvc" /v Start /t REG_DWORD /d 4 /f

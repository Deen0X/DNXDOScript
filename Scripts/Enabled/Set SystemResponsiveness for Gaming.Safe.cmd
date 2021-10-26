@echo off
echo SystemResponsiveness for Gaming (default value is 20, that means 20% reserved for background processes)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

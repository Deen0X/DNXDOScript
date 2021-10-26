@echo off
echo Show drive letters before drive label
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v ShowDriveLettersFirst /t REG_DWORD /D 4 /f
taskkill /f /im explorer.exe
start explorer.exe

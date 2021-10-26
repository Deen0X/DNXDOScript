@echo off
echo Remove TaskViewButton from Windows Bar
reg ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MultitaskingView\AllUpView /v Enabled /t REG_DWORD /d 0 /f

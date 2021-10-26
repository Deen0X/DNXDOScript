@echo off
echo Disabling Timeline
reg ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System /v EnableActivityFeed /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System /v PublishUserActivities /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System /v UploadUserActivities  /t REG_DWORD /d 0 /f

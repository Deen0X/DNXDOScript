@echo off
echo Disabling VBS [Virtualization Based Security] CPU
bcdedit /set hypervisorlaunchtype off
reg ADD HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\DeviceGuard /v EnableVirtualizationBasedSecurity  /t REG_DWORD /d 0 /f

@echo off
echo FIX for search menu (delete a reg entry and enable Windows Geolocalization service "lfsvc")
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\TriggerInfo\3 /f
sc config lfsvc start= auto

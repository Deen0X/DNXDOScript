@echo off
echo Set up core affinity to foreground process
echo possible values
echo 2A Hex _ 42 Dec = Short, Fixed , High foreground boost.
echo 29 Hex _ 41 Dec = Short, Fixed , Medium foreground boost.
echo 28 Hex _ 40 Dec = Short, Fixed , No foreground boost.
echo.
echo 26 Hex _ 38 Dec = Short, Variable , High foreground boost.
echo 25 Hex _ 37 Dec = Short, Variable , Medium foreground boost.
echo 24 Hex _ 36 Dec = Short, Variable , No foreground boost.
echo.
echo 1A Hex _ 26 Dec = Long, Fixed, High foreground boost.
echo 19 Hex _ 25 Dec = Long, Fixed, Medium foreground boost.
echo 18 Hex _ 24 Dec = Long, Fixed, No foreground boost.
echo.
echo 16 Hex _ 22 Dec = Long, Variable, High foreground boost.
echo 15 Hex _ 21 Dec = Long, Variable, Medium foreground boost.
echo 14 Hex _ 20 Dec = Long, Variable, No foreground boost.

:: note: value is in decimal
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

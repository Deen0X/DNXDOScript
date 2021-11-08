@echo off
setlocal enableDelayedExpansion
call :getTotalRAM xRAM
:: If you want to specific the size of the pagefile, you can define on the following variable
:: Take enote this value is in KB, so if you want 1GB Virtual Memory, then you must set to 1024
:: value -1 is for automatic calculation
set UserDefinedVM=-1

echo It changes the boot configuration of Windows so that it is in effect every time you boot. 
echo Not all computers and not all applications play nice with it. 
echo If you find your computer has become unstable, or an application has become unstable, 
echo you can revoke it with "bcdedit /set IncreaseUserVa 2048"
echo This tweak is basically for 32 bits programs.
echo This script will set the value of IncreaseUserVa to half of memory RAM
echo.
if %xRAM% LEQ 4 (
echo Less or Equal to 4GB, set default value for this parameter.
	set xmyVM=2048
) else (
	set /a xmyVM=%xRAM%/ 2
	set /a xmyVM=!xmyVM! * 1024
)
pause


if %UserDefinedVM% GTR 0 set xmyVM=%UserDefinedVM%


echo Current RAM installed: %xRAM%GB
echo calculated Value     : %xmyVM%KB
echo.
bcdedit /set increaseuserva %xmyVM%
timeout /t 5

goto :ToEnd

:getTotalRAM :{
setlocal enableDelayedExpansion
	if not defined tempFN set tempFN=%temp%\PS-%RANDOM%%RANDOM%%RANDOM%%RANDOM%.out.txt
	set tMEM=0
	for /F "TOKENS=2 DELIMS==" %%A in ('WMIC memorychip GET Capacity /VALUE') DO (
		set SLO=%%A
		set /a myGB=1024*1024*1024
		set "myC=powershell -Command "!SLO:~0,-1!/!myGB!""
		!myC! >"%tempFN%"
		set /p xGB=<"%tempFN%"
		set /a tMEM+=!xGB!
rem		echo xGB=!xGB!
rem		echo tMEM=!tMEM!
	)
	
(
	endlocal
	set %1=%tMEM%
	exit /b
)
:}

:ToEnd
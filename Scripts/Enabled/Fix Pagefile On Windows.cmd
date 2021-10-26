@echo off
call :getTotalRAM xRAM

:: If you want to specific the size of the pagefile, you can define on the following variable
:: Take enote this value is in KB, so if you want 1GB Virtual Memory, then you must set to 1024
:: value -1 is for automatic calculation
set UserDefinedVM=-1

echo Fix pagefile on Windows (this config is for GPD specific config, so you can change this to your own needs)
echo there is no a general rule for set this value, because depends on the machine and their usage
echo so, my recommendation is to try to reach 12GB total ram, but never set more than the 50% of the 
echo current ram as virtual, this mean if you have:
echo if you have less than 8GB RAM, set the virtual memory = RAM/2
echo if you have more than 8GB RAM, set the virtual memory = 2GB
echo.
echo if you have more than 16GB, you have enough RAM memory for run most games, and maybe you can set
echo virtual memory to 0 (zero), but windows is not designed to run without virtual memory, so the 
echo performance is not so good as you set some virtual memory. for this reason, my recommendation for
echo machines with more than 8GB RAM (most probably will be 16GB), is to set 2GB as virtual memory.
echo the following configuration is for 4GB RAM, so virtual memory will be 2GB
echo for references:
echo GPD-WIN1 = 4GB
echo GPD-WIN2 = 8GB
echo GPD-MicroPC =8GB
echo GPD-WINMAX = 16GB
echo GPD-WIN3 = 16GB
echo.
if %xRAM% LEQ 8 (
echo Less or Equal to 8
	set /a myVM=xRAM/2
) else if %xRAM% LEQ 12 (
echo Less or Equal to 12
	set /a myVM=4
) else (
	set /a myVM=2
)
if %myVM%==0 set myVM=1

set /a xmyVM=%myVM% * 1024

if %UserDefinedVM% GTR 0 set xmyVM=%UserDefinedVM%


echo Current RAM installed: %xRAM%GB
echo Virtual Memory       : %xmyVM%KB
echo.
:: First disable pagefile
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=false

:: Now set the pagefile size
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%xmyVM%,MaximumSize=%xmyVM%
rem wmic pagefileset where name=”C:\\pagefileGPD.sys” set InitialSize=2048,MaximumSize=2048
timeout /t 5

goto :ToEnd

:getTotalRAM :{
setlocal enableDelayedExpansion
	if not defined tempFN set tempFN=%temp%\PS-%RANDOM%%RANDOM%%RANDOM%%RANDOM%.out.txt
	for /F "TOKENS=2 DELIMS==" %%A in ('WMIC memorychip GET Capacity /VALUE') DO (
		set SLO=%%A
		set /a myGB=1024*1024*1024
		set "myC=powershell -Command "!SLO:~0,-1!/!myGB!""
		!myC! >"%tempFN%"
		set /p xGB=<"%tempFN%"
	)
(
	endlocal
	set %1=%xGB%
	exit /b
)
:}

:ToEnd
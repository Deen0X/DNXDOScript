@echo off
setlocal enableextensions enabledelayedexpansion
cd /d "%~dp0"
pushd "%~dp0"
set bDebug=0
cls
goto :StartScript

:: __________________________________________________________________ sub InitColors
:: Initialize color variables
:InitColors :{
	set cReset=[0m
	set cBold=[1m
	set cUnder=[4m
	set cInv=[7m

	set caBLACK=0
	set caRED=1
	set caGREEN=2
	set caYELLOW=3
	set caBLUE=4
	set caMAGENTA=5
	set caCYAN=6
	set caWHITE=7
	set caTEST=88

	set coFORE=3
	set coNORMAL=3
	set coFORENORMAL=3
	set coBACK=4
	set coBACKNORMAL=4
	set coFORESTRONG=9
	set coBACKSTRONG=10
	
	set cTAFore=Yellow
	set cTAForeType=STRONG
	set cTABack=Red
	set cTABackType=NORMAL

:: standard colors for powershell window	
	set cDeFore=white
	set cDeType=normal
	set cDeBack=blue
	set cdeBackType=normal
(	
exit /b)
:}

:: __________________________________________________________________ sub InitColors
:: Set string to be printed in colors
:cText varText {outVar} [foreColor] [forType] [backColor] [backType] :{
setlocal disableDelayedExpansion
	set myV1=%3
	set myVS1=%4
	set myV2=%5
	set myVS2=%6
	
rem	if "_%myV1%"=="_" set myV1=%cDeFore%
rem	if "_%myVS1%"=="_" set myVS1=%cDeType%
rem	if "_%myV2%"=="_" set myV2=%cDeBack%
rem	if "_%myVS2%"=="_" set myVS2=%cDeBackType%

	if defined ca%myV1% (
		if /I "_%myVS1%" EQU "_strong" (
			call set xFCol=9%%ca%myV1%%%
		) else (
			call set xFCol=3%%ca%myV1%%%
		)
	) else (
rem		set xFCol=3%caWHITE%
	)

	if defined ca%myV2% (
		if /I "_%myVS2%" EQU "_strong" (
			call set xBCol=10%%ca%myV2%%%
		) else (
			call set xBCol=4%%ca%myV2%%%
		)
	) else (
rem		set xFCol=3%caWHITE%
	)
 	
	rem set myXCol=%xBCol%;%xFCol%
	set iCC=0
	if "_%xFCol%" NEQ "_" set /a iCC+=1
	if "_%xBCol%" NEQ "_" set /a iCC+=1
	if %iCC% == 2 (
		set myXCol=%xBCol%;%xFCol%
	) else (
		set myXCol=%xBCol%%xFCol%
	)
	set rcVar=[%myXCol%m%~1[0m
	if %bDebug%==1 (
		echo ====== sub cText [%1] [%2] [%3] [%4] [%5] [%6]
		echo * xBCol         =%xBCol%
		echo * xFCol         =%xFCol%
		echo * myXCol        =%myXCol%
		echo * rcVar         =%rcVar%
	)
(
	endlocal
	set %2=%rcVar%
	exit /b
)
:}


:StartScript
	call :InitColors
	set "BaseDirProc=%~dp0"
	set "ScriptPath=%~0"
	set bReadOnly=0
	set "runPath=%temp%\MicrosoftStore\LTSC-Add-MicrosoftStore-2019"
	set "runPath2=%BaseDirProc%..\..\Extras\MicrosoftStore\LTSC-Add-MicrosoftStore-2019\" 

	call :cText "kkkgo" kkkgo white strong green strong
	echo Downloading and running Microsoft Store (70MB aprox) installation script by %kkkgo%
	echo Be Patient...
	echo This script will install Microsoft Store, App Installer, Purchase App and XBox Identity.
	echo.
	echo check GitHub link for more info:
	call :ctext "https://github.com/kkkgo/LTSC-Add-MicrosoftStore" sTXT black normal white strong
	echo %sTXT%
	echo.
	if not exist "%runPath2%Add-Store.cmd" (
		powershell Invoke-WebRequest "https://github.com/lixuy/LTSC-Add-MicrosoftStore/archive/2019.zip" -OutFile "%temp%\MicrosoftStore.zip"
		set "sCMD=Expand-Archive -F '%temp%\MicrosoftStore.zip' '%temp%\MicrosoftStore'"
rem		echo sCMD=%sCMD%
rem		echo sCMD=!sCMD!
rem		echo powershell -command !sCMD!
		powershell -command !sCMD!
		
		if not exist "%temp%\MicrosoftStore.zip" (
			echo Can´t download the required file.
			echo try downloading directly this link:
			echo https://github.com/lixuy/LTSC-Add-MicrosoftStore/archive/2019.zip
			echo uncompress and copy the files on the following directory:
			echo %BaseDirProc%..\..\MicrosoftStore\LTSC-Add-MicrosoftStore-2019\
			echo and run again this script.
			goto :ToEnd
		)
		if not exist "%runPath2%" (
			echo trying to create file structure on main Script folder...
			mkdir "%runPath2%" >nul
			echo Copying unpacked files to DNXDOScript directory...
			xcopy "%runPath%\" "!runPath2!" >nul
		)
	)

	if not exist "%runPath2%" (
		echo Running from system Temp folder...
		set bReadOnly=1
	) else (
		echo Running from Main Script folder...
		set "runPath=!runPath2!"
	)
	rem powershell -Command "(gc '%RootPath%\DNXSharedFolder.wsb') -replace '##ROOTDNXPSOFTFOLDER##', '%MainFolder%' | Set-Content '%RootPath%\DNXSharedFolder.wsb' -Encoding Default"
	copy "%runPath%\Add-Store.cmd" "%runPath%\DNXAdd-Store.cmd" >nul
	
	powershell -Command "(gc '%runPath%\DNXAdd-Store.cmd') -replace 'pause', 'rem pause' | Set-Content '%runPath%\DNXAdd-Store.cmd' -Encoding Default"
	rem echo start "%runPath%\DNXAdd-Store.cmd"
	rem pause
	start "Installing Microsoft Store" "%runPath%\DNXAdd-Store.cmd"
:ToEnd

@echo off
setlocal enableextensions enabledelayedexpansion
cd /d "%~dp0"
pushd "%~dp0"
cls
set iXCMD=%1
if "_%iXCMD%"=="_" set iXCMD=0
if %iXCMD%==0 (
	echo Re-Launching script with necessary environment setup [Admin and Unrestricted Execution Policy]
	set "myF=%~dpnx0"
	call :stringPS "!myF!" xRun
rem	echo xRun=!xRun!
	set "PSRun=powershell -ExecutionPolicy Unrestricted Start-Process powershell -Verb "runAs '!xRun! 1'""
rem	echo PSRun=!PSRun!
	!PSRun!
	goto :ToEnd2
)
rem call :write "ExecutionPolicy: "
rem powershell get-ExecutionPolicy

set bDebug=0
:: Not necessary to check admin.
:: goto :isAdmin2
:: :IsAdminBack

call :InitScript "%0"
Goto :ToStartScript

:: your code must start on ToStartScript label.


:: ================================================================================================
:: ================================================================================================
:: ================================================================================================

:: __________________________________________________________________ Sub isAdmin
:: Check if the current run environment is admin. Need to create ":IsAdminBack" label to return
:isAdmin :{
setlocal disableDelayedExpansion
	set myP0=%~1
    set myRC=0
    net session >nul 2>&1
    if %errorLevel% == 0 (
        rem echo Success: Administrative permissions confirmed.
        set myRC=1
    ) else (
		rem echo Failure: Current permissions inadequate.
		set myRC=0
		echo "%~0" "%~1" "%~2">%temp%\DNXMainTemp.cmd
		set "myPS=powershell Start-Process powershell -Verb "runAs %temp%\DNXMainTemp.cmd""
		call %%myPS%%
		goto :eof
	)
(
	endlocal
	goto :IsAdminBack
)
:}

:: __________________________________________________________________ sub InitScript
:: Main Initialization routine
:InitScript param0 :{
	set mySFN=%~1
	call :InitColors
	call :writeInitialize
(
exit /b)
:}

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
	exit /b)
:}

:: __________________________________________________________________ sub cTextAlert
:: Quick set alert color for string text
:cTextAlert varText {outVar} [forecolor] [fortype] [backcolor] [backtype] :{
	set myT=%~1
	set myV1=%3
	set mySV1=%4
	set myV2=%5
	set mySV5=%6
	
	if "_%myV1%" NEQ "_" (
		set cTAFore=%myV1%
	)
	if "_%mySV1%" NEQ "_" (
		set cTAForeType=%mySV1%
	)
	if "_%myV2%" NEQ "_" (
		set cTABack=%myV2%
	)
	if "_%mySV2%" NEQ "_" (
		set cTABackType=%mySV2%
	)
	call :cText "%myT%" %cTAFore% %cTAForeType% %cTABack% %cTABackType% rcVar
(
	endlocal
	set %2=%rcVar%
	exit /b)
:}

:: __________________________________________________________________ sub swriteXY
:: print text on X,Y position
:writeXY X Y text :{
setlocal disableDelayedExpansion

FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
rem 	<NUL SET /P "=%ESC%[4;6HBye"
	<NUL SET /P "=%ESC%[%2;%1H%~3"
(
	endlocal
	exit /b) 
:}

:: __________________________________________________________________ sub getFolderName
:: Get the parent folder from some file
:getFolderName somePath {outVar} :{
setlocal enableextensions enabledelayedexpansion
	SET CDIR=%~dp1
	SET _CDIR=%CDIR:~1,-1%
	for %%i in ("%_CDIR%") do SET FolderName=%%~nxi
(
	endlocal
	set %2=%FolderName%
	exit /b
)
:}

:: __________________________________________________________________ sub sTrim
:: Clear string spaces from left and right
:sTrim strIn {outVar} :{
setlocal enableextensions enabledelayedexpansion
	set str=%~1&rem
	call :sTrimL "%str%" strRC
	call :sTrimR "%strRC%" strRC2
(
	endlocal
	set %2=%strRC2%
	exit /b
)
:}

:: __________________________________________________________________ sub sTrimL
:: Clear string spaces from left
:sTrimL strIn {outVar} :{
setlocal enableextensions enabledelayedexpansion 
	set str=%~1&rem
	for /l %%a in (1,1,31) do if "!str:~-1!"==" " set str=!str:~0,-1!
(
	endlocal
	set %2=%str%
	exit /b
)
:}

:: __________________________________________________________________ sub sTrimR
:: Clear stringspaces from right
:sTrimR strIn {outVar} :{
setlocal enableextensions enabledelayedexpansion 
	set str=%~1&rem
	for /f "tokens=* delims= " %%a in ("%str%") do set str=%%a
(
	endlocal
	set %2=%str%
	exit /b
)
:}

:: __________________________________________________________________ sub sSplit
:: split variable string by token
:sSplit sVar sToken {outVar1} {outvar2} {outvar3}...{outvar7} :{
setlocal enableextensions enabledelayedexpansion
	set tVar=%~1
	set tToken=%~2
	set tMaxSplit=6
	if not defined tMaxSplit set tMaxSplit=9
	set iCount=0
	set iCountb=-1
	set lPos=-1
	call :strLen "%tToken%" tTokenLen
	call :inStr "%tVar%" "%tToken%" 0 lPos
	call set aa=%%tVar:~-%tTokenLen%%%
	if "_%aa%" NEQ "_%tToken%" (
rem		echo adding token
		set tVar=%tVar%%tToken%
	)
rem	echo tTokenLen=%tTokenLen%
rem	echo aa=%aa%.
rem	echo tToken=%tToken%.
rem	echo tVar=%tVar%.
rem	pause
	:loopsSplit
		set /a iCount+=1
		set /a iCountb+=1
		set sVar=%tVar:~0,!lPos!%
		set /a lPosb=!lPos!-1
		set /a lPosDif=!lPosb!+tTokenLen
		call set vVar=%%tVar:~0,!lPosb!%%
		call set tVar=%%tVar:~!lPosDif!,1000%%
		call :inStr "%tVar%" "%tToken%" 0 lPos
		if !iCount! GTR %tMaxSplit% (
			set tmp_!iCount!=%vVar%%tToken%%tVar%
			goto :loopsSplitExit
		) else (
			set tmp_!iCount!=%vVar%
		)
	
	if %bDebug%==10 (
		echo ==== Debug sSplit
			echo * iCount    =%iCount%
			echo * var1      =%~1
			echo * vVar      =%vVar%
			echo * tVar      =%tVar%
			echo * tmp_1     =%tmp_1%
			echo * tmp_2     =%tmp_2%
			echo * tmp_3     =%tmp_3%
			echo * tmp_4     =%tmp_4%
			echo * tmp_5     =%tmp_5%
			echo * tmp_6     =%tmp_6%
			echo * tmp_7     =%tmp_7%
			pause

	)
	if "_%tVar%" NEQ "_" goto :loopsSplit
	:loopsSplitExit
(
	endlocal
	if "_%3" NEQ "_" set %3=%tmp_1%
	if "_%4" NEQ "_" set %4=%tmp_2%
	if "_%5" NEQ "_" set %5=%tmp_3%
	if "_%6" NEQ "_" set %6=%tmp_4%
	if "_%7" NEQ "_" set %7=%tmp_5%
	if "_%8" NEQ "_" set %8=%tmp_6%
	if "_%9" NEQ "_" set %9=%tmp_7%
	exit /b
)
:}

:: __________________________________________________________________ sub sSplit5
:: updated split routine
:sSplit5 strVar stToken {outVar1} {outVar2} ... {outVar7} :{
setlocal enableDelayedExpansion
	set sTxt=%~1
	set sTkn=%~2
	set iCount=0
	call :strLen "%sTkn%" lTkn
rem set "stxt=uno_dos_tres_cuatro"
	:loopsSplit5
	call set "strR=%%sTxt:*%sTkn%=%%"
	call set "strL=%%stxt:%strR%=%%"
	if "_%strL%" NEQ "_" (
		call set "strL=%%strL:~0,-%lTkn%%%"
	)

rem	echo lTkn=%lTkn%
rem	echo sTxt=%sTxt%
rem	echo strR=%strR%
rem	echo strL=%strL%

	set "sTxt=%strR%"
	set /a iCount+=1
	
	if "_%strL%" NEQ "_" (
		set "xOut!icount!=%strL%"
rem		call echo xOut!icount!=%%xOut!icount!%%
		Goto :loopsSplit5
	)
	set "xOut!icount!=%strR%"
	
(
	endlocal
	if "%3" NEQ "" set "%3=%xOut1%"
	if "%4" NEQ "" set "%4=%xOut2%"
	if "%5" NEQ "" set "%5=%xOut3%"
	if "%6" NEQ "" set "%6=%xOut4%"
	if "%7" NEQ "" set "%7=%xOut5%"
	if "%8" NEQ "" set "%8=%xOut6%"
	if "%9" NEQ "" set "%9=%xOut7%"
	exit /b
)
:}

:: __________________________________________________________________ sub sSplitB
:: take the first character on the input parameter and assign as splitter token
:sSplitB sToken+strIn {outVar} :{
setlocal enableextensions enabledelayedexpansion 
	set tVar=%~1
	set tToken=%tVar:~0,1%
	set tVar=%tVar:~1,1000%
	set tMaxSplit=7
	if not defined tMaxSplit set tMaxSplit=9
	set iCount=0
	set iCountb=-1
	set lPos=-1
	call :strLen "%tToken%" tTokenLen
	call :inStr "%tVar%" "%tToken%" tTokenLen lPos
	:loopsSplitB
		set /a iCount+=1
		set /a iCountb+=1
		set sVar=%tVar:~0,!lPos!%
		set /a lPosb=!lPos!-1
		set /a lPosDif=!lPosb!+tTokenLen
		call set vVar=%%tVar:~0,!lPosb!%%
		call set tVar=%%tVar:~!lPosDif!,1000%%
		if !iCount! GTR %tMaxSplit% (
			set tmp_!iCount!=%vVar%%tToken%%tVar%
			goto :loopsSplitExitB
		) else (
			set tmp_!iCount!=%vVar%
		)
	
		if %bDebug%==10 (
			echo ==== Debug sSplit
				echo * iCount    =%iCount%
				echo * var1      =%~1
				echo * vVar      =%vVar%
				echo * tVar      =%tVar%
				echo * lPos      =!lPos!
				echo * tmp_1     =%tmp_1%
				echo * tmp_2     =%tmp_2%
				echo * tmp_3     =%tmp_3%
				echo * tmp_4     =%tmp_4%
				echo * tmp_5     =%tmp_5%
				echo * tmp_6     =%tmp_6%
				echo * tmp_7     =%tmp_7%
				pause

		)
		call :inStr "%tVar%" "%tToken%" 0 lPos
	if !lPos! NEQ 0 goto :loopsSplitB
	:loopsSplitExitB
	if "_%tVar%" NEQ "" (
		set /a iCount+=1
		set tmp_!iCount!=%tVar%
	)
(
	endlocal
	if "_%2" NEQ "_" set %2=%tmp_1%
	if "_%3" NEQ "_" set %3=%tmp_2%
	if "_%4" NEQ "_" set %4=%tmp_3% 
	if "_%5" NEQ "_" set %5=%tmp_4%
	if "_%6" NEQ "_" set %6=%tmp_5%
	if "_%7" NEQ "_" set %7=%tmp_6%
	if "_%8" NEQ "_" set %8=%tmp_7%
	if "_%9" NEQ "_" set %9=%tmp_8%
	exit /b
)
:}

:: __________________________________________________________________ sub CreateShortCut
:: Create a shortcut
:CreateShortCut sDest sPath sTitle sArgs sIcon sINum :{
setlocal enableextensions enabledelayedexpansion
rem oLink.TargetPath
rem oLink.Arguments
rem oLink.Description
rem oLink.HotKey
rem oLink.IconLocation
rem oLink.WindowStyle
rem oLink.WorkingDirectory
rem oLink.Save
	set sDest=%~1
	set sPath=%~2
	set sTitle=%~3
	set sArgs=%~4
	set sIcon=%~5
	set sWork=%~dp1
	set SCRIPT="%TEMP%\DNSPScriptCreateSC-%RANDOM%%RANDOM%%RANDOM%%RANDOM%.vbs"

	call :checkDIRF "%sPath%" sPath

	if %bDebug%==4 (
		echo * sDest      =%sPath%
		echo * sPath      =%sPath%
		echo * sTitle     =%sTitle%
		echo * sArgs      =%sArgs%
		echo * sIcon      =%sIcon%
		echo * sWork      =%sWork%
		echo * SCRIPT     =%SCRIPT%
	)
	
rem Creating File	
	echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
	echo sLinkFile = "%sPath%%sTitle%.lnk" >> %SCRIPT%
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
	echo oLink.TargetPath = "%sDest%" >> %SCRIPT%
	echo oLink.Arguments = "%sArgs%" >> %SCRIPT%
	echo oLink.WorkingDirectory = "%sWork%" >> %SCRIPT%
	echo oLink.IconLocation = "%sIcon%" >> %SCRIPT%
	echo oLink.Save >> %SCRIPT%
	cscript /nologo %SCRIPT%
	del %SCRIPT%
(
endlocal
exit /b
)
:}

:: __________________________________________________________________ sub inStr
:: search string into another string
:inStr strVar strF stAt {outVar} :{
rem example:
rem call :inStr %RootPath%New New 0 Var3
setlocal enabledelayedexpansion
	if %bDebug%==6 echo inStr [%1] [%2] [%3] [%4] [%5]
	rem @echo on 
	set str1=%~1
	set sstr=%~2
	set stAt=%3
	
rem	set /a stAt=%stAt%-1
	call :strlen "%str1%" len1
	call :strlen "%sstr%" len2
	set /a stop=len1-len2
	set fpos=0
	
	if %bDebug%==6 (
		echo ==== Debug inStr
		echo * str1          =%str1%
		echo * sstr          =%sstr%
		echo * stAt          =%stAt%
		echo * len1          =%len1%
		echo * len2          =%len2%
		echo * stop          =%stop%
	)
	
	if %stop% gtr 0 for /l %%i in (%stAt%,1,%stop%) do (
		if "!str1:~%%i,%len2%!"=="%sstr%" (
			set /a position=%%i+1
			goto ExitinStr1
		)
	)
:ExitinStr1
	if defined position (
		set fpos=%position%
	) else (
		set fpos=0
	)
(
	endlocal
	set %4=%fpos%
	exit /b
)
:}

:: __________________________________________________________________ checkDIRF
:: check if the argument (must be an directory) ends with "\"
:checkDIRF strVar {outVar} :{
setlocal enableextensions enabledelayedexpansion
	set mySV=%~1
	call :strLen "%mySV%" mySVLen
	rem start counting from zero
 	set /a mySVLen=%mySVLen%-1
	set mySVLen=%mySVLen%
	call set myLL=%%mySV:~%mySVLen%,1%%%
	if "_%myLL%" NEQ "_\" (
		set sRC=%mySV%\
	) else (
		set sRC=%mySV%
	)
(
	endlocal
	set %2=%sRC%
	exit /b
)
:}

:: __________________________________________________________________ Sub IsFile
:: Check if the argument is a file or directory (must exist)
:IsFile strVar {outVar} :{
SETLOCAL ENABLEEXTENSIONS
	set ATTR=%~a1
	set DIRATTR=%ATTR:~0,1%

	if /I "%DIRATTR%"=="d" (
		set sRC=DIR
	) else (
		set sRC=FILE
	)
(
	endlocal
	set %2=%sRC%
	exit /b
)
:}

:: __________________________________________________________________ Sub strLen
:: Get the lenght of a string
:strLen strVar {outVar} :{
(   
    setlocal EnableDelayedExpansion
    rem (set^ xtmp="!%~1!")
	set "xtmp=%~1"
rem 	echo var1=%1
rem 	echo var1b=%~1
rem 	echo xtmp=!xtmp!
rem 	pause
    if defined xtmp (
        set "len=1"
        for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!xtmp:~%%P,1!" NEQ "" ( 
                set /a "len+=%%P"
                set "xtmp=!xtmp:~%%P!"
            )
        )
    ) ELSE (
        set len=0
    )
)
( 
    endlocal
    set "%~2=%len%"
    exit /b
)
:}

:: __________________________________________________________________ sub Write
:: Write a string without return line, stripping quotes
:write strVar :{
setlocal disableDelayedExpansion
	::
	:: Write the literal string Str to stdout without a terminating
	:: carriage return or line feed. Enclosing quotes are stripped.
	::
	:: This routine works by calling :writeVar
	::
	set "strVar=%~1"
	set "strLen=%~2"
	call :writeVar strVar strLen
endlocal
(
	exit /b
)
:}

:: __________________________________________________________________ sub WriteVar
:: Write a string without return line
:writeVar strVar :{
if not defined %~1 exit /b
setlocal enableDelayedExpansion
	::
	:: Writes the value of variable StrVar to stdout without a terminating
	:: carriage return or line feed.
	::
	:: The routine relies on variables defined by :writeInitialize. If the
	:: variables are not yet defined, then it calls :writeInitialize to
	:: temporarily define them. Performance can be improved by explicitly
	:: calling :writeInitialize once before the first call to :writeVar
	::
	if not defined $write.sub call :writeInitialize
	set $write.special=1
	if "!%~1:~0,1!" equ "^!" set "$write.special="
	for /f delims^=^ eol^= %%A in ("!%~1:~0,1!") do (
	  if "%%A" neq "=" if "!$write.problemChars:%%A=!" equ "!$write.problemChars!" set "$write.special="
	)
	if not defined $write.special (
	  <nul set /p "=!%~1!"
	  exit /b
	)
	>"%$write.temp%_1.txt" (echo !str!!$write.sub!)
	copy "%$write.temp%_1.txt" /a "%$write.temp%_2.txt" /b >nul
	type "%$write.temp%_2.txt"
	del "%$write.temp%_1.txt" "%$write.temp%_2.txt"
	set "str2=!str:*%$write.sub%=%$write.sub%!"
	if "!str2!" neq "!str!" <nul set /p "=!str2!"
endlocal
(
	exit /b
)
:}

:: __________________________________________________________________ sub writeInitialize
:: Write function initialization
:writeInitialize :{
	::
	:: Defines 3 variables needed by the :write and :writeVar routines
	::
	::   $write.temp - specifies a base path for temporary files
	::
	::   $write.sub  - contains the SUB character, also known as <CTRL-Z> or 0x1A
	::
	::   $write.problemChars - list of characters that cause problems for SET /P
	::      <carriageReturn> <formFeed> <space> <tab> <0xFF> <equal> <quote>
	::      Note that <lineFeed> and <equal> also causes problems, but are handled elsewhere
	::
	set "$write.temp=%temp%\writeTemp%random%"
	copy nul "%$write.temp%.txt" /a >nul
	for /f "usebackq" %%A in ("%$write.temp%.txt") do set "$write.sub=%%A"
	del "%$write.temp%.txt"
	for /f %%A in ('copy /z "%~f0" nul') do for /f %%B in ('cls') do (
	  set "$write.problemChars=%%A%%B    ""
	  REM the characters after %%B above should be <space> <tab> <0xFF>
	)
(
	exit /b
)
:}

:: __________________________________________________________________ sub stringPS
:: Replace spaces on string, adding a ` character, to be used on powershell parameters
:stringPS strVar {outVar} :{
setlocal enableextensions enabledelayedexpansion
	set var1=%~1
	set varRC=%var1: =` %
(
	endlocal
	set %2=%varRC%
	exit /b
)
:}

:: __________________________________________________________________ sub LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:LoCase strVar {outVar} :{
	set myV=%~1
	FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "Ñ=ñ" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO (
		CALL SET "myV=%%myV:%%~i%%"
	)
(
	set %2=%myV%
	exit /b
)
:}

:: __________________________________________________________________ sub UpCase
:: Subroutine to convert a variable VALUE to all UPPER CASE.
:UpCase strVar {outVar} :{
	set myV=%~1
	FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO (
		CALL SET "myV=%%myV:%%~i%%"
	)
(
	set %2=%myV%
	exit /b
)
:}

:: __________________________________________________________________ sub TCase
:: Subroutine to convert a variable VALUE to Title Case.
:TCase strVar {outVar} :{
	set myV=%~1
	call :LoCase "%myV%" myV
	set myV= %myV%
	FOR %%i IN (" a= A" " b= B" " c= C" " d= D" " e= E" " f= F" " g= G" " h= H" " i= I" " j= J" " k= K" " l= L" " m= M" " n= N" " o= O" " p= P" " q= Q" " r= R" " s= S" " t= T" " u= U" " v= V" " w= W" " x= X" " y= Y" " z= Z") DO (
		CALL SET "myV=%%myV:%%~i%%"
	)
	set myV=%myV:~1,1000%
(
	set %2=%myV%
	exit /b
)
:}

:: __________________________________________________________________ sub EndMessage
:: write a standard exit message from the script 
:EndMessage :{
	echo No olvides visitarnos en: 
	echo Portable Master Race (ESP) https://t.me/gpdwinhispano
	echo Deen0X's Blog: https://www.deen0x.com
	echo DNX Projects: https://github.com/Deen0x
	echo Zalu2^^!
	echo Have a nice day!

(
	exit /b
)
:}

:: __________________________________________________________________ sub writeL
:: Write a string without return line, stripping quotes, adding spaces up to len specified
:writeL strVar [strLen] [strText2] :{
setlocal enableDelayedExpansion
	set "sVar=%~1"
	set lVar=%2
	if "_%2" NEQ "_" (
		set "sFill=                                                                                                   ."
		:: sFill = 1000 spaces
		set sFill=!sFill!!sFill!!sFill!!sFill!!sFill!!sFill!!sFill!!sFill!!sFill!!sFill!
		set "sVar=!sVar!!sFill!"_
		call set sVar=!!sVar:~0,%lVar%!!
	) else (
		set sVar=%2
	)
	call :write "!sVar!%~3"
(
	endlocal
	exit /b
)
:}

:: __________________________________________________________________ sub getFreeRAM
:: get available ram 
:getFreeRAM {outVar} :{
for /f "skip=1" %%p in ('wmic os get freephysicalmemory') do ( 
  set m=%%p
  goto :getFreeRAMdone
)
:getFreeRAMdone
(
	endlocal
	set %1=%m%
	exit /b
)
:}


:: __________________________________________________________________ sub getTotalRAM
:: Get total ram 
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
):}

:: __________________________________________________________________ sub SetWallpaper
:: Set the Windows Wallpaper
:SetWallpaper strVar :{
	set myWP=%~1
	copy "%myWP%" "C:\Windows\DNXWallPaper.jpg" >nul
	reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\DNXWallPaper.jpg" /f  >nul
	RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
	powershell sleep 5
	RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
(
	exit /b
)
:}

:: ================================================================================================
:: ================================================================================================
:: ================================================================================================


:: __________________________________________________________________ sub InitMyScript
:: Initialization user script
:InitMyScript :{
	set "BaseDirProc=%~dp1"
	set "ScriptPath=%~1"
	
	:: subscripts windows mode when launched. MAX MIN NORMAL FILEOUT
	set rSUBPROC=NORMAL
	
	::Color for subscript windows
	set rSUBPROCCOLOR=8F

	::filename for temp outfiles
	set tempFN=%temp%\PS-%RANDOM%%RANDOM%%RANDOM%%RANDOM%.out.txt
	
	rem echo BaseDirProc=%BaseDirProc%
	
	set xmyIcon=%BaseDirProc%Extras\DNXDOScript.ico
	set myIconN=0
	set myIcon=%xmyIcon%
	if NOT exist "%xmyIcon%" (
		echo asignando icono por defecto
		set myIcon=%SystemRoot%\System32\SHELL32.dll,130
		set myIconN=126
	)
(
	exit /b
)
:}

:: __________________________________________________________________ sub ProcessDir
:: Process files in folder
:ProcessDir strFolder strMask strTitle :{
	set strFolder=%~1
	set strMask=%~2
	set sTitle=%~3
	echo.
	call :ctext "%sTitle%" sTXT yellow strong
	echo %sTXT%
	
	for /r "%strFolder%" %%i in (%strMask%) do (
		call :sSplit "%%~ni" "_" sVar1 sVar2 sVar3 sVar4 sVar5 sVar6 sVar7
		
 		call :writeL "- !sVar2!" 76 "["
		call :stringPS "%%i" sPS
		set "sCMD=start /WAIT /%rSUBPROC% powershell -Command "cmd /C color %rSUBPROCCOLOR%; !sPS!""
		set myXT=%%~xi
		set sLet=!myXT:~1,1!
		if "%%~xi"==".reg" (
			regedit /s !sCMD! 
		) else (
			!sCMD! 
		rem !sCMD! >!tempFN!
		)
		call :write "!sLet!"
		%sELOK%
	)
(
	exit /b
)
:}


:: __________________________________________________________________ sub ToStartScript
:: Start User Script
:ToStartScript :{
	call :initMyScript "%~0" "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8" "%~9"
	call :ctext "W4RHH4WK" sW4R black normal green normal
	call :ctext "## DNX ##" sDNX black normal green normal
	call :ctext "OK" sOK yellow normal blue strong
	call :ctext "NO" sNO black normal red strong
	set sELOK=echo ] %sOK%!
	set sELNOK=echo ] %sNO%!
	
	set RunMode=%1
	if "_%RunMode%"=="_/safe" (
		set "RunMode=SAFE"
		set "RMFilter=.safe"
	) else (
		set "RMFilter="
		set "RunMode=NORMAL"
	)
:: ___________________


:: goto :ToStartScript2
	cls
	rem goto :ToStartScript2
	call :ctext "Deen0X Debloat and Optimization Script for Windows 10 v2.0: DNXDOScript" sTXT white strong cyan normal
	title Deen0X Debloat and Optimization Script [DNXDOScript]
	echo %sTXT%
	echo -----------------------------------------------------------------------
	echo.
	echo The original script was created with focus on GPD gaming devices, for improve their performance
	echo (basically GPD-WIN/WIN2) but you can try this on any windows 10 based device.
	echo.
	echo The original idea is based on the "Debloat Windows 10" project from "%sW4R%"
	call :ctext "https://github.com/W4RH4WK/Debloat-Windows-10" sTXT blue strong white normal
	echo %sTXT%
	echo But i add my own code with stuff i found on internet, researching about how to gain performance
	echo on low-powered machines for gaming.
	echo.
	echo For more information about this script and updates, visit the main page:
	call :ctext "https://www.github.com/DNXDOScript" sTXT blue strong white normal
	echo %sTXT%
	echo.
	echo.
	echo.
	call :cText "ATTENTION" sTXT black normal red strong
	echo ===============================================================================================
	echo ================================== %sTXT% ==================================================
	echo ===============================================================================================
	call :cText "WILL MODIFY IN DEEP YOUR CURRENT WINDOWS INSTALLATION" sTXT black normal red strong
	echo This procedure %sTXT% and cannot
	echo be reverted
	echo.
	echo There is any kind of warranty about their execution, so i recommend to create a 
	echo backup/recover point on windows before running this script.
	call :ctext "You will use this at your own risk." sTXT red strong white normal
	echo %sTXT%
	echo.
	echo ===============================================================================================
	echo ===============================================================================================
	Timeout /T 5
	echo (10 seconds timer. default answer is No)
	call :ctext "Do you want to contine?" sTXT black normal white strong
	call :write "%sTXT%"
	choice /C YN /N /T 10  /D N /M " [Y]es/[N]o "
	if errorlevel 2 goto :ToEnd
	echo. 

	echo This script can run in two modes:
	echo SAFE   - Run only scripts considered safe to run on any machine. This
	echo          mode will not in-deep modify the system, but their effect is
	echo          limited compared than the NORMAL mode.
	echo          Use this mode for machines that you will use for working.
	echo NORMAL - Run all enabled scripts. In deep modifications on the system.
	echo          Use this mode for machines that you will use basically for
	echo          gaming, such GPD-WIN/WIN2, Tablets, etc.
	choice /c SN /M "Run in Safe or Normal mode?"
	if errorlevel 2 (
		set "RMFilter="
		set "RunMode=NORMAL"
	)
	if errorlevel 1 (
		set "RMFilter=.safe"
		set "RunMode=SAFE"
	)
	echo selected %RunMode% mode
	echo.
	echo (10 seconds timer. default Minimized)
	choice /c NM /D M /T 10 /M "Run SubScripts in Normal or Minimized mode?"
	if errorlevel 2 (
		set "rSUBPROC=MIN"
	)
	if errorlevel 1 (
		set "rSUBPROC=NORMAL"
	)
	echo selected %rSUBPROC% mode
	echo (10 seconds timer. default is Yes)
	choice /c YN /D Y /T 10 /M "Create restore point?"
	if errorlevel 1 (
		powershell Enable-ComputerRestore -Drive 'C:\'
		powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "MyRestorePoint" -RestorePointType "MODIFY_SETTINGS""
	)
	
	cls
:ToStartScript2
	call :ctext "%RunMode%" sTXT black normal yellow normal
	echo Runnin in %sTXT% mode
rem	echo RMFilter=%RMFilter%
	echo.
	call :cText "Note:" sTXT green strong blue normal
	echo %sTXT% Some steps may take long time on solve, so it is normal for
	echo the system to appear to be unresponsive.
	echo Take a little pacience.
	echo.
	echo %sTXT% Maybe subscripts show some errors when running. This is normal
	echo and you don´t need to worry about this.
	echo.
	echo =====================================================================
	call :ctext "%RunMode%" sTXT yellow normal blue normal
	echo Main Run Mode        : %sTXT%
	call :ctext "%rSUBPROC%" sTXT yellow normal blue normal
	echo SubScript window mode: %sTXT%
	echo =====================================================================
	echo.
	call :cText "Step 1" sTXT black normal yellow normal
	echo %sTXT%: Debloat Windows scripts and optimization for gaming station.
	echo.
 	echo Setting environment for script execution...

	call :writeL "- Unblock PowerShell scripts and modules within this directory" 76 "["
	powershell -ExecutionPolicy Unrestricted -command "ls -Recurse *.ps*1 | Unblock-File"
	call :write "."
	powershell -Command "ls -Recurse *.psm1 | Unblock-File"
	%sELOK%


:: __________________________________________________________________ WSubScripts	
	call :ProcessDir "%BaseDirProc%Scripts\Enabled\" "*%RMFilter%.*" "** Running Subscripts **"

	call :writeL "- Set Custom Wallpaper" 76 "["
	call :SetWallpaper "%BaseDirProc%Extras\Wallpaper.jpg"
	call :write "."
	%sELOK%
	
:: __________________________________________________________________ WUtils	
	call :ProcessDir "%BaseDirProc%Utils\Enabled\" "*%RMFilter%.*" "** Running Utils **"

	call :writeL "- Adding Windows Start Menu Entry for this Script" 76 "["
	set sDESTShortCut=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\DNXScript
	if not exist "%sDESTShortCut%" mkdir "%sDESTShortCut%"
	call :CreateShortCut "%~dpnx1" "%sDESTShortCut%" "DNXDOScript - Debloat and Optimiaztion Script by Deen0X" "" "%myIcon%" ""
	call :writeL "."
	%sELOK%
	echo.

:}

:ToEnd
call :EndMessage
pause

:ToEnd2

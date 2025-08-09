@echo off
rem [ SETTINGS ]==========================================================
set AppName=Steam Account Shortcut Generator
set AppAuthor=h4k70rx
set AppVersion=v2025.03.16
set AppHomePage=https://github.com/h4k70rx
set AppExtName=sas
rem ======================================================================

rem [ APPLICATION ]=======================================================
title %AppName%

if not exist "Steam.exe" (
	echo [ERROR]: Cannot find Steam.exe!
	echo [ERROR]: Please, put the program in the Steam.exe directory!
	echo.
	pause
	exit
)

if NOT "%1" == "run" (
	goto INSTALL
)

if not exist "%2.%AppExtName%" (
	del "*.%AppExtName%"
	type nul > "%2.%AppExtName%"
	taskkill /F /IM Steam.exe /T
	reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %2 /f
	reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
)

start steam://open/main
exit

:INSTALL
echo               --------------------------------------------
echo               %AppName% %AppVersion%
echo               ----------- Developed by %AppAuthor% -----------
echo.
echo                      [ %AppHomePage% ]
echo.
echo **************************************************************************
echo *                                                                        *
echo * This application generate shortcuts to steam accounts on your desktop. *
echo *                                                                        *
echo **************************************************************************
echo *                                                                        *
echo * You can make multiple shortcuts with different steam accounts and      *
echo * when you launch steam from one of these shortcuts,                     *
echo * it will automatically switch to selected shortcut account.             *
echo *                                                                        *
echo **************************************************************************
echo *                                                                        *
echo * If you launch for first time, you will have to enter your name,        *
echo * password and check "remember me", after that everything is automatic.  *
echo *                                                                        *
echo **************************************************************************
echo.

:EAN
set /P account=Please, enter your steam account name: 

if "%account%" == "" (
	echo [ERROR]: You cannot enter empty account name!
	echo.
	echo.
	echo.
	goto EAN
)

echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%HOMEDRIVE%%HOMEPATH%\Desktop\Steam [%account%].lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%~f0" >> CreateShortcut.vbs
echo oLink.Arguments = "run %account%" >> CreateShortcut.vbs
echo oLink.Description = "Steam [%account%] Launcher" >> CreateShortcut.vbs
echo oLink.HotKey = "" >> CreateShortcut.vbs
echo oLink.IconLocation = "%cd%\Steam.exe" >> CreateShortcut.vbs
echo oLink.WindowStyle = "1" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%cd%" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
exit
rem ======================================================================
@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: Win11 ExplorerPatcher Installer
REM Filedescription: Installs/ Uninstalls / Updates Win11 ExplorerPatcher
REM Copyrights: @Fixxxer
REM Trademarks: 
REM Originalname: Win11EP.exe
REM Comments: Default action - uninstall. If dxgi.dll exists in the same folder - installs/updates with this file.
REM Productversion:  2. 0. 0. 0
REM Fileversion:  2. 0. 0. 0
REM Internalname: Win11EP.exe
REM ExeType: ghost
REM Architecture: x86
REM Appicon: X:\FIXXXER\11\Win11EP\Icon1.ico
REM AdministratorManifest: Yes
REM Embeddedfile: X:\FIXXXER\11\Win11EP\movefile.exe
REM Embeddedfile: X:\FIXXXER\11\Win11EP\movefile64.exe
REM Embeddedfile: X:\FIXXXER\11\Win11EP\curl.exe
REM Embeddedfile: X:\FIXXXER\11\Win11EP\curl-ca-bundle.crt
REM Embeddedfile: X:\FIXXXER\11\Win11EP\libcurl.dll
REM Embeddedfile: X:\FIXXXER\11\Win11EP\exit.vbs
REM Embeddedfile: X:\FIXXXER\11\Win11EP\help.vbs
REM  QBFC Project Options End
@ECHO ON
set xOS=x64& if "%PROCESSOR_ARCHITECTURE%"=="x86" (if not defined PROCESSOR_ARCHITEW6432 set xOS=x86)
reg add "HKCU\Software\Sysinternals\Movefile" /v "EulaAccepted" /t REG_DWORD /d 00000001 /f

if "%~1"=="u" goto uninstall
if "%~1"=="U" goto uninstall
if "%~1"=="/u" goto uninstall
if "%~1"=="/U" goto uninstall
if "%~1"=="-u" goto uninstall
if "%~1"=="-U" goto uninstall

if "%~1"=="i" goto install
if "%~1"=="I" goto install
if "%~1"=="/i" goto install
if "%~1"=="/I" goto install
if "%~1"=="-i" goto install
if "%~1"=="-I" goto install

start /wait wscript "%MYFILES%\help.vbs"
goto end

:install
call :deleteonreboot
if exist dxgi.dll goto nodownload
%MYFILES%\curl.exe -L "https://github.com/valinet/ExplorerPatcher/releases/latest/download/dxgi.dll" -o .\dxgi.dll -s
:nodownload
move /y dxgi.dll %windir%\dxgi.dll
goto finish

:uninstall
call :deleteonreboot
rd /s /q "%userprofile%\AppData\Roaming\ExplorerPatcher"
goto finish

:deleteonreboot
if exist %windir%\dxgi.dll (move /y %windir%\dxgi.dll %windir%\dxgi0.dl0)
if exist %windir%\dxgi0.dl0 if "%xOS%"=="x64" (%MYFILES%\movefile64.exe "%windir%\dxgi0.dl0" "")
if exist %windir%\dxgi0.dl0 if "%xOS%"=="x86" (%MYFILES%\movefile.exe "%windir%\dxgi0.dl0" "")
exit /B 0

:finish
start /wait wscript "%MYFILES%\exit.vbs"
:end
rem pause
reg delete "HKCU\Software\Sysinternals\Movefile" /f
del %~s0 /q /f

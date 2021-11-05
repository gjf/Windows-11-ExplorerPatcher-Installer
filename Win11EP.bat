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
REM Productversion:  1. 0. 0. 0
REM Fileversion:  1. 0. 0. 0
REM Internalname: Win11EP.exe
REM ExeType: consoleold
REM Architecture: x86
REM Appicon: X:\FIXXXER\11\Win11EP\Icon1.ico
REM AdministratorManifest: Yes
REM Embeddedfile: X:\FIXXXER\11\Win11EP\movefile.exe
REM Embeddedfile: X:\FIXXXER\11\Win11EP\movefile64.exe
REM  QBFC Project Options End
@ECHO ON
set xOS=x64& if "%PROCESSOR_ARCHITECTURE%"=="x86" (if not defined PROCESSOR_ARCHITEW6432 set xOS=x86)
reg add "HKCU\Software\Sysinternals\Movefile" /v "EulaAccepted" /t REG_DWORD /d 00000001 /f

if exist %windir%\dxgi.dll (rename %windir%\dxgi.dll dxgi0.dl0)
if exist %windir%\dxgi0.dl0 if "%xOS%"=="x64" (%MYFILES%\movefile64.exe "%windir%\dxgi0.dl0" "")
if exist %windir%\dxgi0.dl0 if "%xOS%"=="x86" (%MYFILES%\movefile.exe "%windir%\dxgi0.dl0" "")

if exist dxgi.dll (copy /b /v /y .\dxgi.dll %windir%\dxgi.dll)

reg delete "HKCU\Software\Sysinternals\Movefile" /f
del %~s0 /q /f

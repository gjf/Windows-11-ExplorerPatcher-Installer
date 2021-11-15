@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: Win11 ExplorerPatcher Installer
REM Filedescription: Installs/ Uninstalls / Updates Win11 ExplorerPatcher
REM Copyrights: @Fixxxer
REM Trademarks: 
REM Originalname: Win11EP.exe
REM Comments: Default action - uninstall. If dxgi.dll or ep_setup.exe exists in the same folder - installs/updates with this file.
REM Productversion:  3. 0. 0. 0
REM Fileversion:  3. 0. 0. 0
REM Internalname: Win11EP.exe
REM ExeType: ghost
REM Architecture: x86
REM Appicon: E:\Repositories\Windows-11-ExplorerPatcher-Installer\Icon1.ico
REM AdministratorManifest: Yes
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\RH.exe
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\movefile.exe
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\movefile64.exe
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\curl.exe
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\curl-ca-bundle.crt
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\libcurl.dll
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\exit.vbs
REM Embeddedfile: E:\Repositories\Windows-11-ExplorerPatcher-Installer\MYFILES\help.vbs
REM  QBFC Project Options End
@ECHO ON
set xOS=x64& if "%PROCESSOR_ARCHITECTURE%"=="x86" (if not defined PROCESSOR_ARCHITEW6432 set xOS=x86)
set name=%random%
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
if exist ep_setup.exe goto nodownload
%MYFILES%\curl.exe -L "https://github.com/valinet/ExplorerPatcher/releases/latest/download/ep_setup.exe" -o .\ep_setup.exe -s
:nodownload
if exist ep_setup.exe call :unpack_exe
move /y dxgi.dll %windir%\dxgi.new
if "%xOS%"=="x64" (%MYFILES%\movefile64.exe "%windir%\dxgi.new" "%windir%\dxgi.dll")
if "%xOS%"=="x86" (%MYFILES%\movefile.exe "%windir%\dxgi.new" "%windir%\dxgi.dll")
goto finish

:uninstall
call :deleteonreboot
rd /s /q "%userprofile%\AppData\Roaming\ExplorerPatcher"
goto finish

:deleteonreboot
if exist %windir%\dxgi.dll (move /y %windir%\dxgi.dll %windir%\%name%.old)
if exist %windir%\%name%.old if "%xOS%"=="x64" (%MYFILES%\movefile64.exe "%windir%\%name%.old" "")
if exist %windir%\%name%.old if "%xOS%"=="x86" (%MYFILES%\movefile.exe "%windir%\%name%.old" "")
exit /B 0

:unpack_exe
%MYFILES%\RH.exe -open ep_setup.exe -save dxgi.dll -action extract -mask RCData,103, -log NUL )
del .\ep_setup.exe /q /f
del %MYFILES%\RH.ini /q /f
exit /B 0

:finish
start /wait wscript "%MYFILES%\exit.vbs"
:end
reg delete "HKCU\Software\Sysinternals\Movefile" /f
del %~s0 /q /f

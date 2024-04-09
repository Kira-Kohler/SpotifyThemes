@echo off
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto :continue ) else ( goto :getadmin )

:getadmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:continue
set folder=C:\Users\%USERNAME%\AppData\Local\Spotify\Update

echo Verificando la existencia de la carpeta %folder%...
timeout /t 2 >nul
if exist "%folder%" (
    echo La carpeta existe. Eliminando la carpeta...
    timeout /t 2 >nul
    rd /s /q "%folder%"
    echo Carpeta eliminada exitosamente.
    timeout /t 2 >nul
)

echo Creando una nueva carpeta %folder%...
timeout /t 2 >nul
mkdir "%folder%"
echo Carpeta creada exitosamente.
timeout /t 2 >nul

echo Concediendo permisos para el script en %folder%...
timeout /t 2 >nul
icacls "%folder%" /grant:r "%USERNAME%:(OI)(CI)F" /T /Q
timeout /t 2 >nul

echo Denegando permisos en %folder%...
timeout /t 2 >nul
icacls "%folder%" /inheritance:r /deny "Todos:(OI)(CI)(F)" /T /Q
echo Permisos denegados exitosamente en %folder%.
timeout /t 2 >nul

pause

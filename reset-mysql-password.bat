@echo off
title Reset MySQL Root Password
cd /d "%~dp0"

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ========================================================
    echo  ATTENTION: Administrator Rights Required!
    echo ========================================================
    echo  Please right-click on this file:
    echo    "reset-mysql-password.bat"
    echo  and choose:
    echo    "Run as administrator"
    echo ========================================================
    pause
    exit /b
)

echo ========================================================
echo  Resetting MySQL Root Password to: root
echo ========================================================
echo.

echo ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; > "%TEMP%\mysql_reset.sql"

echo [1/4] Stopping MySQL80 service...
net stop MySQL80

echo [2/4] Resetting root password with temporary init script...
start /b "" "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" --init-file="%TEMP%\mysql_reset.sql"

timeout /t 5 /nobreak >nul
taskkill /F /IM mysqld.exe >nul 2>&1

echo [3/4] Restarting MySQL80 service...
net start MySQL80

if exist "%TEMP%\mysql_reset.sql" del "%TEMP%\mysql_reset.sql"

echo.
echo ========================================================
echo  SUCCESS: Your MySQL root password is now reset to: root
echo ========================================================
echo  Go back to your browser (http://127.0.0.1:3001)
echo  and click "Retry Connection".
echo ========================================================
pause

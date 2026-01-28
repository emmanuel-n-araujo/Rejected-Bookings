@echo off
title Rejected Bookings Dashboard
cd /d "%~dp0"

echo.
echo ========================================
echo   Starting Rejected Bookings Dashboard
echo ========================================
echo.

:: Kill previous node instances to free up port 3000
echo Stopping previous servers...
taskkill /F /IM node.exe >nul 2>&1
echo.

:: Start the browser after a short delay
start "" cmd /c "timeout /t 2 >nul && start http://localhost:3000"

:: Start the server using full path to Node.js
"C:\Users\Norton Araujo\scoop\apps\nodejs\current\node.exe" server.js

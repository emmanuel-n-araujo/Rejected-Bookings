@echo off
title Rejected Bookings Dashboard (Direct File Access)
cd /d "%~dp0"

echo.
echo ========================================
echo   Launching Dashboard with File Access
echo ========================================
echo.
echo   Opening dashboard.html in Edge with security flags...
echo   (This is required to auto-load local files without a server)
echo.

:: Launch Edge with the allow-file-access-from-files flag
:: Pointing to the local HTML file

if exist "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" (
    start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --allow-file-access-from-files "%~dp0dashboard.html"
) else (
    echo Edge not found in standard location. Trying generic launch...
    start msedge --allow-file-access-from-files "%~dp0dashboard.html"
)

echo Done! You can close this window.
timeout /t 5 >nul
exit

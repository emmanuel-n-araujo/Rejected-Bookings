@echo off
echo ========================================
echo Pushing Rejected Bookings Dashboard to GitHub
echo ========================================
echo.

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not found in PATH
    echo Please restart your terminal or computer after installing Git
    echo Then run this script again.
    pause
    exit /b 1
)

echo Git version found:
git --version
echo.

REM Check if .git exists
if exist ".git" (
    echo Git repository already exists.
    echo.
) else (
    echo Initializing Git repository...
    git init
    echo.
)

REM Configure git user (if not already configured)
git config user.name >nul 2>&1
if errorlevel 1 (
    echo Setting up Git user configuration...
    git config user.name "Norton Araujo"
    git config user.email "norton.araujo@onedevelopment.ae"
    echo.
)

REM Add remote if it doesn't exist
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo Adding GitHub remote...
    git remote add origin https://github.com/emmanuel-n-araujo/Rejected-Bookings.git
    echo.
) else (
    echo Remote 'origin' already exists.
    echo.
)

REM Add all files
echo Adding files to Git...
git add .
echo.

REM Commit
echo Committing changes...
git commit -m "Complete Rejected Bookings Dashboard with date fixes and UI refinements"
echo.

REM Set main branch
echo Setting branch to main...
git branch -M main
echo.

REM Push to GitHub
echo Pushing to GitHub...
echo You may be prompted for GitHub credentials.
git push -u origin main
echo.

if errorlevel 0 (
    echo ========================================
    echo SUCCESS! Dashboard pushed to GitHub
    echo Repository: https://github.com/emmanuel-n-araujo/Rejected-Bookings
    echo ========================================
) else (
    echo ========================================
    echo Push failed. You may need to:
    echo 1. Authenticate with GitHub
    echo 2. Check repository permissions
    echo ========================================
)

echo.
pause

@echo off
setlocal
title HandyConnect - Portable Launcher
set "PROJECT_DIR=%~dp0"

echo ===================================================================
echo               HANDYCONNECT - PORTABLE LAUNCHER
echo ===================================================================
echo Running from: %PROJECT_DIR%
echo.

:: Check Python
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please install Python 3.10+ from https://www.python.org/
    pause
    exit /b 1
)

:: Check Node.js
node --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed or not in PATH!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo [1/4] Checking Python Backend dependencies...
cd /d "%PROJECT_DIR%backend"
pip install -r requirements.txt >nul 2>&1 || pip install django djangorestframework django-cors-headers >nul 2>&1

echo [2/4] Checking React Frontend dependencies...
cd /d "%PROJECT_DIR%frontend"
if not exist "node_modules\" (
    echo Installing frontend packages (this only happens on first run, please wait 1-2 minutes)...
    call npm install
)

echo [3/4] Starting Backend (Django on port 8000)...
cd /d "%PROJECT_DIR%backend"
start "HandyConnect Backend (Django)" cmd /k "python manage.py runserver 8000"

echo [4/4] Starting Frontend (React on port 5173)...
cd /d "%PROJECT_DIR%frontend"
start "HandyConnect Frontend (React)" cmd /k "npm run dev"

echo.
echo Waiting for servers to initialize...
timeout /t 4 >nul

echo Opening browser at http://localhost:5173/ ...
start http://localhost:5173/

echo.
echo ===================================================================
echo   HandyConnect is now running! Keep server windows open.
echo   Frontend: http://localhost:5173/
echo   Backend:  http://127.0.0.1:8000/
echo ===================================================================
pause

@echo off
setlocal
cd /d "%~dp0bastion-os"

echo.
echo ========================================
echo   BASTION OS - Starting dev server
echo ========================================
echo.

if not exist "node_modules" (
  echo Installing dependencies...
  call npm install
  if errorlevel 1 (
    echo npm install failed.
    pause
    exit /b 1
  )
)

echo Stopping any old BASTION dev servers...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3002" ^| findstr "LISTENING"') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3000" ^| findstr "LISTENING"') do (
  tasklist /FI "PID eq %%a" /FO CSV | findstr /I "node.exe" >nul && taskkill /PID %%a /F >nul 2>&1
)

if exist ".next\dev" (
  echo Clearing stale Next.js dev lock...
  rmdir /s /q ".next\dev" 2>nul
)

echo.
echo Open in browser:  http://localhost:3002/life
echo Press Ctrl+C to stop the server.
echo.

call npm run dev
pause

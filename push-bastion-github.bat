@echo off
cd /d "%~dp0bastion-os"
echo Pushing BASTION OS to GitHub...
echo.
echo If this fails with "Repository not found", create an empty repo first:
echo   https://github.com/new?name=bastion-os
echo   (Do NOT add README, .gitignore, or license)
echo.
git push -u origin main
if errorlevel 1 (
  echo.
  echo Push failed. Create the repo at the link above, then run this script again.
  pause
  exit /b 1
)
echo.
echo Done! https://github.com/AMBUJ-DWIVEDI/bastion-os
pause

@echo off

cd /d D:\SRC

set PORT=8888

for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":%PORT% " ^| findstr LISTENING') do taskkill /pid %%p /f >nul 2>&1

powershell -NoProfile -Command "Start-Process python -ArgumentList '-u','apptest.py' -WorkingDirectory '.\' -WindowStyle Hidden -RedirectStandardOutput '.\out.log' -RedirectStandardError '.\err.log'"

netstat -ano | findstr ":%PORT% " | findstr LISTENING

timeout /t 3 >nul

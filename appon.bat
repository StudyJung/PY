@echo off
taskkill /im python3.13.exe /f

cd /d D:\SRC
set PORT=8888

for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":%PORT% " ^| findstr LISTENING') do taskkill /pid %%p /f >nul 2>&1

powershell -NoProfile -Command "Start-Process python -ArgumentList '-u','apptest.py' -WorkingDirectory 'D:\SRC' -WindowStyle Hidden -RedirectStandardOutput 'D:\SRC\out.log' -RedirectStandardError 'D:\SRC\err.log'"

timeout /t 3 >nul
netstat -ano | findstr ":%PORT% " | findstr LISTENING
if errorlevel 1 (
  echo [X] 기동 실패. err.log 내용:
  type D:\SRC\err.log
  pause
) else (
  echo [O] 백그라운드 기동 완료: http://localhost:%PORT%
  timeout /t 3 >nul
)

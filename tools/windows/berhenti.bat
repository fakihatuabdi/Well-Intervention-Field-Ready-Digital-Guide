@echo off
rem Menghentikan aplikasi. Data tetap tersimpan.
cd /d "%~dp0\..\.."
docker compose stop
echo Aplikasi dihentikan. Jalankan mulai.bat untuk menyalakan lagi.
pause

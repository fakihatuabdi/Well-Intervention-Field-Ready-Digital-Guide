@echo off
rem Menjalankan aplikasi Well Intervention Guide di laptop ini (Docker/Rancher/Podman).
setlocal
cd /d "%~dp0\..\.."

where docker >nul 2>nul
if errorlevel 1 (
  echo Program "docker" tidak ditemukan.
  echo Install Rancher Desktop, Podman Desktop, atau Docker Desktop terlebih dahulu.
  echo Lihat docs\audit-it\02-INSTALASI.md
  pause
  exit /b 1
)

if not exist ".env" (
  copy ".env.example" ".env" >nul
  echo File .env dibuat. Isi ADMIN_EMAIL dan ADMIN_PASSWORD, simpan, tutup Notepad,
  echo lalu jalankan mulai.bat sekali lagi.
  notepad ".env"
  pause
  exit /b 0
)

echo Menyiapkan aplikasi. Pertama kali bisa beberapa menit...
docker compose up -d --build
if errorlevel 1 (
  echo.
  echo Gagal menjalankan. Periksa pesan di atas. Pastikan ADMIN_EMAIL dan
  echo ADMIN_PASSWORD di file .env sudah diisi dan program Docker sudah berjalan.
  pause
  exit /b 1
)

echo Menunggu aplikasi siap...
set /a tries=0
:wait
set /a tries+=1
curl -fs http://localhost:3000/up >nul 2>nul
if not errorlevel 1 goto ready
if %tries% GEQ 60 goto slow
timeout /t 3 /nobreak >nul
goto wait

:slow
echo Aplikasi belum menjawab. Lihat log dengan: docker compose logs app
pause
exit /b 1

:ready
echo.
echo Aplikasi berjalan: http://localhost:3000
start "" http://localhost:3000
pause

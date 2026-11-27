# 02. Instalasi

Ada dua cara yang didukung. Keduanya memakai file yang sama (`docker-compose.yml`).

- **A. Server IT / intranet (Linux)**: untuk dipakai banyak orang.
- **B. Laptop Windows**: untuk swakelola, demo, atau pemeriksaan oleh IT.

Kebutuhan minimum: 2 CPU, 2 GB RAM kosong, 3 GB disk.

---

## A. Server Linux (Docker Engine)

1. Install Docker Engine dan plugin Compose (gratis, open source):
   <https://docs.docker.com/engine/install/>
2. Ambil kode aplikasi (git clone atau salin folder ZIP) ke server, lalu masuk ke foldernya.
3. Buat file pengaturan:
   ```bash
   cp .env.example .env
   nano .env        # isi ADMIN_EMAIL dan ADMIN_PASSWORD (wajib), POSTGRES_PASSWORD (disarankan)
   ```
4. Jalankan:
   ```bash
   docker compose up -d --build
   ```
   Build pertama butuh beberapa menit (mengunduh library). Start berikutnya cepat.
5. Buka `http://<alamat-server>:3000` lalu login dengan `ADMIN_EMAIL` / `ADMIN_PASSWORD`.
   Segera ganti password lewat menu **My account**.
6. Cek status: `docker compose ps` (kolom STATUS harus `healthy`) dan
   `curl http://localhost:3000/up` harus mengembalikan HTTP 200.

**HTTPS**: letakkan aplikasi di belakang reverse proxy perusahaan (nginx, IIS,
F5, dll.) yang memegang sertifikat, teruskan ke port 3000, lalu set
`FORCE_SSL=true` di `.env` dan `docker compose up -d` lagi.

---

## B. Laptop Windows

### Langkah 1. Install program untuk menjalankan container (sekali saja)

Pilih **salah satu**:

| Program | Biaya | Catatan |
|---|---|---|
| **Rancher Desktop** (<https://rancherdesktop.io>) | Gratis, open source | Saat setup pilih *Container engine: dockerd (moby)*. Perintah `docker compose` langsung tersedia. |
| **Podman Desktop** (<https://podman-desktop.io>) | Gratis, open source | Aktifkan *Docker compatibility* dan *Compose* di pengaturan. |
| **Docker Desktop** (<https://www.docker.com/products/docker-desktop/>) | Gratis hanya untuk perusahaan kecil | Perusahaan dengan lebih dari 250 karyawan atau omzet di atas USD 10 juta wajib berlangganan berbayar. Untuk perusahaan besar, gunakan Rancher Desktop atau Podman Desktop. |

Ketiganya membutuhkan WSL2 (fitur bawaan Windows 10/11). Installer biasanya
mengaktifkannya otomatis; mungkin perlu restart sekali. Jika laptop dikunci
oleh IT, minta IT untuk menginstall salah satu program di atas.

### Langkah 2. Ambil kode aplikasi

Di GitHub, klik **Code > Download ZIP**, lalu ekstrak, misalnya ke
`C:\wi-guide`. (Atau `git clone` jika Git sudah terpasang.)

### Langkah 3. Jalankan

Klik dua kali **`tools\windows\mulai.bat`**.

- Pertama kali, file akan membuat `.env` dan membukanya di Notepad. Isi
  `ADMIN_EMAIL` dan `ADMIN_PASSWORD` (minimal 10 karakter, huruf dan angka),
  simpan, tutup Notepad, lalu klik dua kali `mulai.bat` lagi.
- Tunggu sampai muncul tulisan "Aplikasi berjalan" (build pertama beberapa menit).
- Browser akan terbuka ke <http://localhost:3000>.

Untuk menghentikan: klik dua kali **`tools\windows\berhenti.bat`**. Data tetap tersimpan.

Perintah manual yang setara (PowerShell, di folder aplikasi):
```powershell
copy .env.example .env; notepad .env
docker compose up -d --build
```

### Agar bisa dibuka dari HP di jaringan yang sama

Buka `http://<IP-laptop>:3000` dari HP (IP laptop terlihat dengan perintah
`ipconfig`). Windows Firewall mungkin menanyakan izin; pilih *Private network*.
Jika hanya ingin diakses dari laptop itu sendiri, ubah `APP_PORT` menjadi
`127.0.0.1:3000` di `.env`.

---

## Install tanpa internet (server tertutup)

Build image di komputer yang punya internet, lalu pindahkan:

```bash
# di komputer dengan internet (folder aplikasi)
docker compose build
docker pull postgres:16-alpine
docker save -o wi-guide-images.tar wi-guide:latest postgres:16-alpine
```

Salin `wi-guide-images.tar` dan folder aplikasi ke server tertutup, lalu:

```bash
docker load -i wi-guide-images.tar
cp .env.example .env && nano .env
docker compose up -d --no-build
```

---

## Operasional

| Tugas | Perintah (di folder aplikasi) |
|---|---|
| Lihat status | `docker compose ps` |
| Lihat log | `docker compose logs -f app` |
| Hentikan | `docker compose stop` |
| Jalankan lagi | `docker compose up -d` |
| Daftar akun | `docker compose exec app bin/rails users:list` |
| Reset password (misal admin lupa) | `docker compose exec app bin/rails users:reset_password EMAIL=nama@perusahaan PASSWORD='PasswordBaru123'` |
| Buat admin tambahan | `docker compose exec app bin/rails users:create_admin EMAIL=... PASSWORD='...'` |

### Backup dan restore

```bash
# backup (simpan file ini di tempat aman)
docker compose exec -T db pg_dump -U wi_guide -Fc wi_guide > backup-wi-guide.dump

# restore ke instalasi baru/kosong
docker compose up -d db
docker compose exec -T db pg_restore -U wi_guide -d wi_guide --clean --if-exists < backup-wi-guide.dump
docker compose up -d
```

Di Windows PowerShell, gunakan `cmd /c "docker compose exec -T db pg_dump -U wi_guide -Fc wi_guide > backup-wi-guide.dump"`
agar file tidak rusak oleh encoding PowerShell.

### Update ke versi baru

```bash
git pull                     # atau ganti folder dengan ZIP versi baru (jangan hapus .env)
docker compose up -d --build # migrasi database berjalan otomatis
```

Data (database, akun, artikel yang diedit) tetap tersimpan di volume Docker.

### Menghapus seluruh aplikasi dan datanya

```bash
docker compose down -v   # -v menghapus volume = SEMUA DATA HILANG
```

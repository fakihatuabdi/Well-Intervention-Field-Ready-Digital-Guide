# Deploy ke Northflank (paket gratis)

Aplikasi ini dibangun dari `Dockerfile` di root repo. Saat container start,
`bin/docker-entrypoint` otomatis menjalankan migrasi database dan seed
(seed hanya menambah konten awal yang belum ada, tidak menghapus data).

## 1. Buat akun dan project
1. Daftar di https://northflank.com (paket **Sandbox**, gratis; kartu hanya untuk verifikasi).
2. Buat **Project** baru, pilih region terdekat (mis. Asia/Singapura jika tersedia).
3. Hubungkan akun GitHub Anda ke Northflank (Account settings → Git integrations).

## 2. Buat database PostgreSQL
Pilih salah satu:

- **Addon Northflank** (kuota 1 database di paket gratis): Project → *Create new* → *Addon* → PostgreSQL.
  Setelah jadi, buka tab *Connection details* dan salin connection URI (`postgresql://...`).
- **Neon** (alternatif gratis, tidak kedaluwarsa): daftar di https://neon.tech, buat project,
  salin *pooled connection string* (berakhiran `?sslmode=require`).

## 3. Buat service aplikasi
1. Project → *Create new* → **Combined service** (build + deploy).
2. Repository: `Well-Intervention-Field-Ready-Digital-Guide`, branch `main`.
3. Build type: **Dockerfile**, path `/Dockerfile`, build context `/`.
4. Networking: port **3000**, protokol HTTP, centang *Publicly expose*.
5. Resource: pilih plan gratis (Sandbox) yang tersedia.
6. Health check (opsional tapi disarankan): HTTP `GET /up` di port 3000.

## 4. Environment variables
Isi di service → *Environment* (sebaiknya lewat *Secret group*):

| Nama | Nilai |
|---|---|
| `DATABASE_URL` | connection URI dari langkah 2 |
| `SECRET_KEY_BASE` | string acak panjang, buat dengan `openssl rand -hex 64` (atau `bin/rails secret`) |
| `ADMIN_EMAIL` | e-mail akun admin pertama (dibuat sekali saat belum ada admin) |
| `ADMIN_PASSWORD` | password admin pertama (min. 10 karakter, huruf dan angka) |
| `FORCE_SSL` | `true` (Northflank sudah HTTPS) |
| `REQUIRE_LOGIN` | `true` (default) agar semua orang harus login, atau `false` agar demo bisa dibaca tanpa login |

Daftar lengkap pengaturan ada di [audit-it/03-KONFIGURASI.md](audit-it/03-KONFIGURASI.md).

`RAILS_ENV`, `PORT`, `RAILS_SERVE_STATIC_FILES` dan `RAILS_LOG_TO_STDOUT` sudah diatur di Dockerfile.
Paket gratis RAM-nya kecil, jadi Dockerfile memakai `WEB_CONCURRENCY=0`
(1 proses Puma, 5 thread). Naikkan hanya jika RAM cukup.

## 5. Deploy dan cek
1. Klik *Create service*; Northflank akan build image lalu menjalankannya.
2. Buka URL publik yang diberikan. Cek juga `https://<url>/up` harus mengembalikan halaman hijau (200).
3. Setiap push ke `main` akan build dan deploy ulang otomatis (bisa dimatikan di pengaturan CI/CD).

## Jalankan di komputer sendiri
Lihat [audit-it/02-INSTALASI.md](audit-it/02-INSTALASI.md) (`docker compose up`).

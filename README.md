# Well Intervention Field-Ready Digital Guide

Handbook digital untuk operasi well intervention (upstream oil & gas), untuk
staf lapangan dan kantor, nyaman dibaca dari HP maupun komputer.

- **Handbook**: General Knowledge dan Zona Rokan Operation (Rig Hub), dengan pencarian dan bookmark.
- **Login dengan dua peran**: *Admin* (mengubah konten, mengelola akun, melihat audit log) dan *Pengguna* (membaca).
- **Jalan 100% lokal**: satu perintah Docker, tanpa layanan internet saat berjalan.
- **Siap diperiksa IT**: dokumen arsitektur, instalasi, konfigurasi, keamanan dan daftar komponen di [`docs/audit-it/`](docs/audit-it/README.md).

## Mulai cepat (Docker)

```bash
cp .env.example .env     # isi ADMIN_EMAIL dan ADMIN_PASSWORD
docker compose up -d --build
```

Buka <http://localhost:3000> dan login sebagai admin. Di Windows cukup klik dua
kali `tools\windows\mulai.bat`. Panduan lengkap: [docs/audit-it/02-INSTALASI.md](docs/audit-it/02-INSTALASI.md).

## Pengembangan

Butuh Ruby 3.3 (lihat `.ruby-version`).

```bash
bundle install
bin/rails db:prepare db:seed
ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD=Admin12345678 bin/rails db:seed   # admin lokal
bin/dev                  # http://localhost:3000
bin/rails test           # tes otomatis
bin/brakeman             # scan keamanan kode
bin/bundler-audit check --update   # scan kerentanan library
```

Development dan tes memakai SQLite; produksi memakai PostgreSQL (`DATABASE_URL`).

## Konten handbook

Artikel ditulis sebagai file Markdown di `db/handbook/` dan dimuat otomatis saat
start (`bin/rails handbook:load`). Artikel yang sudah diubah admin lewat menu
Admin tidak akan ditimpa oleh file.

## Deploy demo online

Panduan Northflank + Neon (gratis): [docs/DEPLOY_NORTHFLANK.md](docs/DEPLOY_NORTHFLANK.md).

## Lisensi

[MIT](LICENSE)

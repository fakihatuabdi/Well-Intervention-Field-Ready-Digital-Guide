# 01. Arsitektur

## Gambaran umum

```
 Pengguna (browser HP / laptop)
        │  HTTP (atau HTTPS lewat reverse proxy perusahaan)
        ▼
 ┌──────────────────────────── satu server / laptop ───────────────────────────┐
 │  Container "app"  (Ruby 3.3 + Rails 8.1, web server Puma, port 3000)        │
 │    - halaman web, login, halaman admin                                      │
 │    - file statis (CSS, JS, gambar handbook) ikut di dalam image             │
 │                  │ koneksi database (jaringan internal Docker saja)          │
 │                  ▼                                                          │
 │  Container "db"   (PostgreSQL 16, TIDAK dibuka ke jaringan)                 │
 │                                                                             │
 │  Volume "db-data"      : isi database                                       │
 │  Volume "app-storage"  : SECRET_KEY_BASE yang dibuat otomatis               │
 └─────────────────────────────────────────────────────────────────────────────┘
```

- Hanya **port 3000** milik container `app` yang dibuka ke jaringan (bisa
  diubah atau dibatasi ke `127.0.0.1`, lihat 03-KONFIGURASI.md).
- Database hanya bisa diakses oleh container `app` di jaringan internal Docker.
- Tidak ada koneksi keluar (outbound) saat aplikasi berjalan.

## Teknologi

| Lapisan | Teknologi |
|---|---|
| Bahasa / framework | Ruby 3.3, Ruby on Rails 8.1 |
| Web server | Puma |
| Database | PostgreSQL 16 (produksi), SQLite (hanya untuk tes otomatis) |
| Login | Devise 5 (password di-hash dengan bcrypt) |
| Tampilan | HTML dari server, Tailwind CSS, Hotwire (Turbo/Stimulus); semua file disajikan dari server sendiri |
| Konten handbook | File Markdown di `db/handbook/` dimuat otomatis ke database saat start |
| Paket | Docker image (`Dockerfile`) + `docker-compose.yml` |

## Data yang disimpan

| Tabel | Isi | Data pribadi? |
|---|---|---|
| `users` | nama, e-mail, hash password, peran, status, jumlah/waktu login, IP login terakhir | Ya (nama, e-mail, IP) |
| `audit_events` | siapa melakukan apa dan kapan, IP | Ya (e-mail, IP) |
| `articles` | isi handbook | Tidak |
| `bookmarks` | artikel yang disimpan pengguna | Terkait akun |
| `updates`, `case_studies` | pengumuman dan studi kasus di beranda | Tidak |
| `chat_messages` | riwayat chat bot (fitur mati secara bawaan) | Terkait akun |

Password tidak pernah disimpan dalam bentuk asli (hanya hash bcrypt) dan tidak
pernah ditulis ke log (parameter `password` disaring dari log).

## Alur konten

1. Konten awal handbook ada di file Markdown `db/handbook/**.md` (ikut di kode).
2. Saat container start, `bin/docker-entrypoint` menjalankan migrasi database
   lalu `db:seed`, yang memuat artikel dari file tersebut. Proses ini **tidak
   pernah menghapus** data dan **tidak menimpa** artikel yang sudah diubah admin.
3. Admin bisa mengubah artikel, pengumuman dan studi kasus dari menu **Admin**.
   Setiap perubahan tercatat di **Audit log**.

## Struktur kode penting

| Lokasi | Isi |
|---|---|
| `app/controllers/` | logika halaman; `admin/` = halaman admin (hanya peran admin) |
| `app/models/user.rb` | peran, status akun, aturan password |
| `app/models/audit_event.rb` | jejak audit |
| `lib/app_settings.rb` | semua pengaturan dari environment variable |
| `config/initializers/content_security_policy.rb` | aturan CSP browser |
| `config/initializers/devise.rb` | aturan login (kunci akun, timeout) |
| `db/handbook/` | konten handbook (Markdown) |
| `test/` | tes otomatis |

# 04. Keamanan

## Kontrol yang diterapkan

| Area | Kontrol | Lokasi di kode |
|---|---|---|
| Autentikasi | Login e-mail + password (Devise 5). Password di-hash bcrypt (cost 12). Minimal 10 karakter, wajib huruf dan angka. | `app/models/user.rb`, `config/initializers/devise.rb` |
| Brute force | Akun terkunci 30 menit setelah 5 kali salah password; percobaan gagal dicatat beserta IP. | `devise.rb`, `config/initializers/audit_failed_sign_in.rb` |
| Enumerasi akun | Mode *paranoid*: pesan login sama untuk e-mail yang tidak ada dan password salah. | `devise.rb` |
| Sesi | Cookie sesi terenkripsi dan `HttpOnly`; logout otomatis setelah 8 jam tidak aktif (bisa diatur); semua sesi "remember me" dibatalkan saat logout. Dengan `FORCE_SSL=true` cookie juga `Secure` dan HSTS aktif. | `devise.rb`, `config/environments/production.rb` |
| Otorisasi | Dua peran: **Admin** dan **Pengguna**. Semua halaman `/admin` diperiksa di server (`Admin::BaseController#require_admin`). Pengguna tidak bisa mengubah perannya sendiri. Admin terakhir tidak bisa menurunkan/menonaktifkan dirinya. | `app/controllers/admin/`, `app/controllers/users/registrations_controller.rb` |
| Pendaftaran | Mati secara bawaan. Jika dinyalakan: dibatasi domain e-mail, akun baru berstatus menunggu persetujuan admin. | `lib/app_settings.rb` |
| Jejak audit | Login, logout, login gagal, pembuatan/perubahan akun, dan setiap perubahan konten dicatat (pelaku, waktu, objek, perubahan, IP). Tidak bisa diubah/dihapus dari aplikasi. | `app/models/audit_event.rb`, menu Admin > Audit log |
| CSRF | Token CSRF Rails aktif di semua form dan permintaan AJAX. | bawaan Rails |
| XSS | Semua output di-escape oleh Rails. Artikel Markdown dibersihkan dengan sanitizer daftar-putih (tag `script`, `iframe`, `form`, atribut `on*` dibuang). | `app/helpers/articles_helper.rb` |
| Content Security Policy | Browser hanya boleh memuat skrip, gaya, gambar dan font dari server sendiri; skrip inline wajib membawa *nonce*; `object-src 'none'`; `frame-ancestors 'self'`. | `config/initializers/content_security_policy.rb` |
| SQL injection | Semua query memakai ActiveRecord dengan parameter; input pencarian di-escape. | `app/models/article.rb` |
| Rahasia | Tidak ada password/kunci di kode. Rahasia hanya lewat environment variable / `.env` (diabaikan git). Parameter sensitif disaring dari log. | `.gitignore`, `config/initializers/filter_parameter_logging.rb` |
| Container | Aplikasi berjalan sebagai user non-root (uid 1000). Image produksi tidak berisi library tes/pengembangan. Database tidak dibuka ke jaringan. | `Dockerfile`, `docker-compose.yml` |
| Koneksi keluar | Tidak ada. Tidak ada CDN, Google Fonts, analytics, Firebase atau API AI. Diuji dengan browser yang memblokir semua alamat di luar server: 0 permintaan keluar. | `app/views/layouts/application.html.erb` |

## Hasil scan (27 November 2026)

| Alat | Fungsi | Hasil |
|---|---|---|
| Brakeman 8.1.1 | Analisis statis keamanan kode Rails | 0 peringatan (1 diabaikan dengan alasan, lihat bawah) |
| bundler-audit 0.9.3 | Mencocokkan semua library Ruby dengan database kerentanan (ruby-advisory-db) | 0 kerentanan |
| importmap audit | Memeriksa library JavaScript | 0 kerentanan |
| Tes otomatis (Minitest) | 47 tes, termasuk tes hak akses, login, kunci akun, CSP | Semua lulus |

Peringatan Brakeman yang diabaikan (`config/brakeman.ignore`): *mass
assignment* `role`/`status` di `Admin::UsersController`. Ini disengaja: halaman
itu khusus admin dan tujuannya memang mengatur peran/status. Halaman daftar
sendiri dan "My account" tidak mengizinkan `role`/`status` (ada tesnya).

Sebelum persiapan audit ini aplikasi memakai Rails 7.1 (sudah tidak menerima
perbaikan keamanan) dan beberapa library dengan kerentanan yang diketahui.
Semuanya sudah diperbarui (Rails 8.1.4.1, Devise 5, Puma 8, Ruby 3.3.14, dll.).

## Menjalankan ulang scan

Dengan Ruby terpasang (di folder aplikasi):
```bash
bundle install
bin/brakeman                     # keamanan kode
bin/bundler-audit check --update # kerentanan library (perlu internet untuk update database)
bin/importmap audit              # library JavaScript
bin/rails test                   # tes otomatis
```

Tanpa Ruby di komputer, scan yang sama berjalan otomatis di GitHub Actions
(`.github/workflows/ci.yml`) setiap ada perubahan kode.

IT juga bisa memindai image Docker dengan alat pilihan IT sendiri, misalnya
`trivy image wi-guide:latest`.

## Batasan yang diketahui / rekomendasi untuk produksi

1. **HTTPS** tidak disediakan oleh aplikasi sendiri. Untuk server yang dipakai
   bersama, pasang di belakang reverse proxy perusahaan dengan sertifikat, lalu
   set `FORCE_SSL=true`.
2. **Reset password lewat e-mail tidak tersedia** (aplikasi tidak memakai mail
   server). Admin mereset password dari menu Admin > Users atau lewat perintah
   `bin/rails users:reset_password`.
3. **Login terpusat (SSO / Active Directory / LDAP) belum ada.** Bisa
   ditambahkan jika IT menghendaki.
4. **Backup** belum otomatis; lihat perintah backup di 02-INSTALASI.md dan
   jadwalkan sesuai kebijakan IT.
5. Gaya inline (`style-src 'unsafe-inline'`) masih diizinkan oleh CSP karena
   beberapa tampilan memakai atribut `style`. Skrip inline tetap dibatasi nonce.
6. Mode `REQUIRE_LOGIN=false` hanya untuk demo; untuk penggunaan perusahaan
   biarkan `true`.

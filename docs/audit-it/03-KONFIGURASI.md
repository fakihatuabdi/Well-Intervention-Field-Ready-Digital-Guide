# 03. Konfigurasi

Semua pengaturan diberikan lewat environment variable. Dengan Docker Compose,
isi di file `.env` (salin dari `.env.example`), lalu jalankan
`docker compose up -d` agar berlaku. Kode yang membaca pengaturan ini ada di
`lib/app_settings.rb`. Setiap pengaturan punya nilai bawaan yang aman.

## Wajib

| Nama | Keterangan |
|---|---|
| `ADMIN_EMAIL` | E-mail akun admin pertama. Dibuat sekali saat start jika belum ada admin; akun yang sudah ada tidak pernah diubah. |
| `ADMIN_PASSWORD` | Password admin pertama. Minimal 10 karakter, ada huruf dan angka. Ganti setelah login pertama. |

## Akses

| Nama | Bawaan | Keterangan |
|---|---|---|
| `REQUIRE_LOGIN` | `true` | `true`: semua halaman wajib login. `false`: siapa pun yang bisa membuka alamatnya boleh membaca handbook (halaman Admin tetap wajib login sebagai admin). |
| `ALLOW_SIGNUP` | `false` | `true`: muncul tombol "Request an account". Akun baru selalu berperan **Pengguna** dan berstatus *menunggu persetujuan* sampai admin menyetujuinya. `false`: hanya admin yang membuat akun. |
| `SIGNUP_EMAIL_DOMAIN` | kosong | Domain e-mail yang boleh mendaftar sendiri, dipisah koma, misal `perusahaan.co.id`. Kosong = semua domain (hanya berlaku jika `ALLOW_SIGNUP=true`). |
| `SESSION_TIMEOUT_MINUTES` | `480` | Pengguna otomatis logout setelah sekian menit tidak aktif. |

Aturan login yang tetap (di `config/initializers/devise.rb`): akun terkunci
30 menit setelah 5 kali salah password (admin bisa membuka kunci lebih cepat),
pesan login tidak membedakan "e-mail tidak ada" dan "password salah".

## Jaringan

| Nama | Bawaan | Keterangan |
|---|---|---|
| `APP_PORT` | `3000` | Port di komputer/server. Contoh `8080`, atau `127.0.0.1:3000` agar hanya bisa dibuka dari mesin itu sendiri. |
| `FORCE_SSL` | `false` | `true` jika pengguna membuka aplikasi lewat HTTPS (reverse proxy). Mengalihkan http ke https, mengirim header HSTS, dan menandai cookie sebagai *secure*. |
| `APP_HOSTS` | kosong | Nama host/IP yang diizinkan, dipisah koma (perlindungan DNS rebinding). Kosong = semua. |
| `APP_TIME_ZONE` | `Asia/Jakarta` | Zona waktu tampilan dan audit log. |

## Fitur

| Nama | Bawaan | Keterangan |
|---|---|---|
| `CHAT_BOT_ENABLED` | `false` | Menampilkan halaman AI Chat Bot. Saat ini chat bot hanya membalas teks tetap (tidak ada AI dan tidak ada koneksi keluar). Jika nanti dihubungkan ke layanan AI, pertanyaan akan dikirim keluar jaringan, maka bawaannya mati. |
| `SEED_DEMO_CONTENT` | `false` | Menambahkan contoh studi kasus dan pengumuman saat start (hanya untuk demo). |

## Lanjutan

| Nama | Bawaan | Keterangan |
|---|---|---|
| `SECRET_KEY_BASE` | dibuat otomatis | Kunci untuk menandatangani cookie sesi. Jika kosong, dibuat acak sekali dan disimpan di volume `app-storage` (`/rails/storage/secret_key_base`, hak akses 600). Mengganti nilai ini membuat semua orang logout. |
| `POSTGRES_PASSWORD` | `wi_guide_local` | Password database. Database tidak dibuka ke jaringan, tetapi tetap disarankan diganti **sebelum start pertama** (setelah database dibuat, mengubah nilai ini saja tidak mengganti password di database). |
| `DATABASE_URL` | diatur oleh compose | Alamat database. Hanya perlu diisi jika memakai PostgreSQL di luar compose. |
| `WEB_CONCURRENCY`, `RAILS_MAX_THREADS` | `0`, `5` | Jumlah proses dan thread Puma. Bawaan cukup untuk ratusan pengguna handbook. |

# Paket dokumen untuk tim IT

Aplikasi **Well Intervention Field-Ready Digital Guide** adalah handbook digital
untuk staf lapangan dan kantor (dibaca dari HP atau komputer). Dokumen di folder
ini disiapkan untuk pemeriksaan (forensik/keamanan) oleh tim IT sebelum
diajukan ke program Digital Initiative.

| Dokumen | Isi |
|---|---|
| [01-ARSITEKTUR.md](01-ARSITEKTUR.md) | Komponen, alur data, data yang disimpan, batas jaringan |
| [02-INSTALASI.md](02-INSTALASI.md) | Cara install di server IT (Linux) dan di laptop Windows, backup, update, install tanpa internet |
| [03-KONFIGURASI.md](03-KONFIGURASI.md) | Semua pengaturan (environment variable) dan nilai bawaannya |
| [04-KEAMANAN.md](04-KEAMANAN.md) | Kontrol keamanan, hasil scan, cara menjalankan ulang scan, batasan yang diketahui |
| [05-KOMPONEN.md](05-KOMPONEN.md) | Daftar komponen utama, versi dan lisensi |
| [daftar-library.csv](daftar-library.csv) | Daftar lengkap semua library Ruby (versi + lisensi), bisa dibuka di Excel |

## Ringkasan singkat

- **Jalan 100% lokal.** Satu perintah (`docker compose up -d --build`) menjalankan
  aplikasi + database PostgreSQL di satu mesin. Saat berjalan, aplikasi tidak
  menghubungi layanan internet apa pun (tidak ada CDN, Google Fonts, analytics,
  Firebase, atau API AI). Internet hanya dibutuhkan saat *membangun* image
  (mengunduh library), dan itu pun bisa dilakukan sekali lalu dipindahkan
  (lihat bagian "Install tanpa internet").
- **Login wajib** (bisa diubah). Dua peran: **Admin** (mengubah konten, mengelola
  akun) dan **Pengguna** (hanya membaca).
- **Konten handbook bersifat umum**, tanpa data sensitif perusahaan.
- **Jejak audit**: login berhasil/gagal dan setiap perubahan oleh admin dicatat
  (siapa, kapan, apa, alamat IP).
- **Scan keamanan otomatis**: Brakeman (kode) dan bundler-audit (library)
  bersih saat dokumen ini dibuat; bisa dijalankan ulang kapan saja.
- **Kode sumber terbuka untuk diperiksa**: seluruh kode ada di repository Git ini.

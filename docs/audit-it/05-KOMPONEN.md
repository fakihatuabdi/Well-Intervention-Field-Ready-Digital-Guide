# 05. Daftar komponen

Semua komponen di bawah gratis dan open source. Daftar lengkap seluruh library
Ruby (termasuk turunan, 122 buah) dengan versi dan lisensinya ada di
[daftar-library.csv](daftar-library.csv). Versi pasti dikunci di `Gemfile.lock`.

## Komponen yang berjalan di produksi

| Komponen | Versi | Lisensi | Fungsi |
|---|---|---|---|
| Ruby (image `ruby:3.3.14-slim`, Debian) | 3.3.14 | Ruby / BSD-2-Clause | Bahasa pemrograman |
| PostgreSQL (image `postgres:16-alpine`) | 16 | PostgreSQL License | Database |
| Ruby on Rails | 8.1.4.1 | MIT | Framework web |
| Puma | 8.1.3 | BSD-3-Clause | Web server |
| Devise / Warden | 5.0.4 / 1.2.9 | MIT | Login dan sesi |
| bcrypt | 3.1.22 | MIT | Hash password |
| pg | 1.7.0 | BSD-2-Clause | Koneksi ke PostgreSQL |
| kramdown + kramdown-parser-gfm | 2.6.1 / 1.1.0 | MIT | Mengubah Markdown artikel ke HTML |
| Nokogiri, rails-html-sanitizer | 1.19.7 / lihat CSV | MIT | Membersihkan HTML artikel |
| Kaminari | 1.3.3 | MIT | Pembagian halaman (pagination) |
| tailwindcss-rails | 4.7.0 | MIT | Membangun file CSS saat build (tidak dipakai saat berjalan) |
| turbo-rails, stimulus-rails, importmap-rails | 2.0.23 / 1.3.4 / 2.2.3 | MIT | JavaScript halaman (file disajikan dari server sendiri) |
| jbuilder, sprockets-rails, bootsnap | lihat CSV | MIT | Pendukung Rails |

## Hanya untuk tes / pemeriksaan (tidak ada di image produksi)

| Komponen | Lisensi | Fungsi |
|---|---|---|
| SQLite (gem sqlite3) | BSD-3-Clause | Database untuk tes otomatis |
| Brakeman | Brakeman Public Use License | Scan keamanan kode |
| bundler-audit | GPL-3.0-or-later | Scan kerentanan library |
| Capybara, Selenium WebDriver, debug, erb_lint, hotwire-livereload | MIT / Apache-2.0 | Tes dan pengembangan |

Image produksi dibangun dengan `BUNDLE_WITHOUT="development:test"`, sehingga
komponen di tabel kedua tidak ikut terpasang.

## Program di laptop/server

| Program | Lisensi | Catatan |
|---|---|---|
| Docker Engine + Compose (Linux) | Apache-2.0 | Gratis |
| Rancher Desktop / Podman Desktop (Windows) | Apache-2.0 | Gratis |
| Docker Desktop (Windows) | Komersial | Gratis hanya untuk perusahaan kecil (lihat 02-INSTALASI.md) |

## Layanan pihak ketiga

**Tidak ada** saat aplikasi berjalan lokal. (Versi demo online memakai
Northflank dan Neon; keduanya tidak diperlukan untuk instalasi lokal.)

# Panduan Deploy ke Render.com

Aplikasi Well Intervention Field-Ready Digital Guide sudah siap untuk di-deploy ke Render.com.

## Langkah-langkah Deploy:

### 1. Persiapan Repository
Push semua perubahan ke GitHub repository Anda:
```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### 2. Deploy ke Render.com

1. **Buat Akun Render**
   - Kunjungi https://render.com
   - Sign up atau login menggunakan akun GitHub Anda

2. **Connect Repository**
   - Klik tombol "New +" di dashboard
   - Pilih "Web Service"
   - Connect repository GitHub Anda
   - Pilih repository aplikasi ini

3. **Konfigurasi Deploy**
   Render akan otomatis mendeteksi file `render.yaml`, atau Anda bisa setup manual:
   
   - **Name**: `wi-field-guide` (atau nama yang Anda inginkan)
   - **Region**: Singapore (paling dekat dengan Indonesia)
   - **Branch**: `main`
   - **Runtime**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`
   - **Plan**: Free

4. **Environment Variables**
   Tambahkan environment variables berikut:
   
   **Rails Configuration:**
   - `RAILS_ENV`: `production`
   - `SECRET_KEY_BASE`: (akan di-generate otomatis atau gunakan: `rails secret`)
   - `RAILS_LOG_TO_STDOUT`: `true`
   - `RAILS_SERVE_STATIC_FILES`: `true`
   
   **Firebase Configuration (PENTING untuk real-time view counter):**
   - `FIREBASE_API_KEY`: `AIzaSyB2Kx60bD58HQ5JqwbqjYaALzEhHQIPbkw`
   - `FIREBASE_AUTH_DOMAIN`: `wi-field-ready-digital-guide.firebaseapp.com`
   - `FIREBASE_DATABASE_URL`: `https://wi-field-ready-digital-guide-default-rtdb.asia-southeast1.firebasedatabase.app`
   - `FIREBASE_PROJECT_ID`: `wi-field-ready-digital-guide`
   - `FIREBASE_STORAGE_BUCKET`: `wi-field-ready-digital-guide.firebasestorage.app`
   - `FIREBASE_MESSAGING_SENDER_ID`: `51623643193`
   - `FIREBASE_APP_ID`: `1:51623643193:web:6f244103625708e57a25e8`

   **Cara menambahkan di Render:**
   1. Buka Render Dashboard
   2. Pilih web service Anda
   3. Klik tab "Environment"
   4. Klik "Add Environment Variable" untuk setiap variabel di atas
   5. Atau gunakan "Add from .env" dan paste semua sekaligus

   **PENTING**: Pastikan file `bin/render-build.sh` berisi:
   ```bash
   #!/usr/bin/env bash
   set -o errexit
   
   bundle install
   bundle exec rake assets:precompile
   bundle exec rake assets:clean
   bundle exec rake db:migrate
   bundle exec rake db:seed  # ← PENTING: Untuk mengisi data awal
   ```

5. **Deploy**
   - Klik "Create Web Service"
   - Render akan otomatis build dan deploy aplikasi
   - Proses pertama biasanya memakan waktu 5-10 menit

### 3. Akses Aplikasi

Setelah deploy berhasil, aplikasi akan tersedia di URL:
```
https://wi-field-guide.onrender.com
```
(atau nama yang Anda pilih)

## Catatan Penting:

### Firebase Tidak Berfungsi di Render?
Jika Firebase menampilkan error "Firebase initialization timeout" atau "credentials not configured":

**Solusi:**
1. Pastikan SEMUA environment variables Firebase sudah ditambahkan di Render (lihat Step 2.4)
2. Redeploy aplikasi setelah menambahkan environment variables:
   - Buka Render Dashboard → pilih service → klik "Manual Deploy" → "Clear build cache & deploy"
3. Check logs untuk memastikan Firebase initialized successfully
4. Lihat browser console (F12) - seharusnya ada log: "🔥 Firebase initialized successfully!"

**Verifikasi:**
- Di browser console (F12), cek apakah ada error Firebase
- Seharusnya muncul: "✅ Firebase initialized successfully"
- Seharusnya muncul: "✅ Article X synced to Firebase: Y views"

### Data Tidak Muncul Setelah Deploy?
Jika setelah deploy artikel dan konten tidak muncul:
1. Pastikan `bin/render-build.sh` menjalankan `rake db:seed`
2. Check logs di Render dashboard untuk memastikan seeds berhasil dijalankan
3. Jika perlu manual seed, gunakan Render Shell:
   - Buka dashboard Render
   - Pilih web service Anda
   - Klik "Shell" tab
   - Jalankan: `bundle exec rake db:seed`

### Free Plan Render.com
- Aplikasi akan sleep setelah 15 menit tidak ada aktivitas
- Request pertama setelah sleep akan memakan waktu 30-60 detik untuk "wake up"
- Cocok untuk testing dan demo
- Tidak ada biaya sama sekali

### Database SQLite
- SQLite berfungsi baik untuk aplikasi read-heavy seperti ini
- Data akan persist selama aplikasi tidak di-redeploy
- Untuk production dengan banyak user, pertimbangkan migrasi ke PostgreSQL

### Auto-Deploy
Setiap kali Anda push ke branch `main`, Render akan otomatis deploy versi terbaru.

### Firebase
Firebase analytics dan database sudah dikonfigurasi dan akan tetap berfungsi di production.

## Troubleshooting

Jika ada error saat deploy:
1. Check logs di Render dashboard
2. Pastikan semua gem terinstall dengan benar
3. Pastikan database migrations berhasil
4. Check environment variables

## Alternative: Railway.app

Jika ingin alternatif lain, Railway.app juga mudah:
1. Kunjungi https://railway.app
2. Login dengan GitHub
3. "New Project" → "Deploy from GitHub repo"
4. Pilih repository
5. Railway akan auto-detect Rails dan deploy

URL: `https://[project-name].up.railway.app`

## Alternative: Fly.io

Untuk performa lebih baik:
```bash
# Install flyctl
curl -L https://fly.io/install.sh | sh

# Deploy
fly launch
fly deploy
```

---

**Rekomendasi**: Untuk kemudahan dan gratis, gunakan Render.com dengan panduan di atas.

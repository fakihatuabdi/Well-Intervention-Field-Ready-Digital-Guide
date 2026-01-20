# Render Deployment Checklist

## ✅ Konfigurasi yang Sudah Benar

### 1. Branch Configuration
- ✅ **Branch utama:** `main`
- ✅ **render.yaml sudah set:** `branch: main`
- ✅ **GitHub default branch:** `main`

### 2. Build Script
File: `bin/render-build.sh`
```bash
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
bundle exec rake db:seed  # ← PENTING: Mengisi database dengan data
```

### 3. Render.yaml Configuration
```yaml
services:
  - type: web
    name: Well-Intervention-Field-Ready-Digital-Guide
    runtime: ruby
    plan: free
    branch: main  # ← PENTING: Eksplisit set ke main
    buildCommand: "./bin/render-build.sh"
    startCommand: "bundle exec puma -C config/puma.rb"
```

## 🔧 Troubleshooting: Halaman Kosong di Render

### Penyebab Umum:
1. ❌ Database belum di-seed
2. ❌ Render menggunakan branch yang salah
3. ❌ Environment variables belum di-set

### Solusi:

#### A. Manual Seed Database (Jika masih kosong)
1. Buka Render Dashboard
2. Pilih service Anda
3. Klik tab **"Shell"**
4. Jalankan:
   ```bash
   rails db:seed
   ```

#### B. Force Redeploy
1. Buka Render Dashboard
2. Klik **"Manual Deploy"**
3. Pilih **"Clear build cache & deploy"**

#### C. Cek Environment Variables
Pastikan sudah set di Render Dashboard:
- `RAILS_ENV=production`
- `SECRET_KEY_BASE` (auto-generated)
- `RAILS_MASTER_KEY` (dari config/master.key)

## 📊 Verifikasi

### Cek Data di Render Shell:
```bash
rails console
```

Kemudian:
```ruby
Article.count
# Harus return: 21 (11 General Knowledge + 10 Rig Hub)

CaseStudy.count
# Harus return: 0 atau lebih

Update.count
# Harus return: 0 atau lebih
```

## 🚀 Deployment Flow

1. **Lokal:** Develop di branch `main`
2. **Commit:** `git add . && git commit -m "message"`
3. **Push:** `git push origin main`
4. **Auto-Deploy:** Render otomatis detect dan rebuild
5. **Wait:** 5-10 menit untuk build selesai
6. **Verify:** Cek aplikasi di URL Render

## ⚠️ PENTING: Single Branch Strategy

Sekarang repository hanya menggunakan **1 branch: `main`**
- ✅ Lokal = `main`
- ✅ GitHub = `main`
- ✅ Render = `main`

**Tidak ada branch lain yang aktif!**

## 📝 Commit History Terakhir

```
f4267c5 - Explicitly set main branch in render.yaml for deployment
b9623dd - Add db:seed to render build script to populate database with initial data
12404b2 - Improve UI consistency: align all badges and standardize card heights
```

Semua update sudah ada di branch `main` dan siap di-deploy!

# Fix Firebase di Render - Panduan Lengkap

## Masalah
Firebase mengalami timeout/error di Render dengan pesan:
- ❌ "Firebase initialization timeout"
- ❌ "Firebase credentials not configured"
- ❌ "Uncaught ReferenceError: module is not defined"

## Penyebab
Environment variables Firebase belum dikonfigurasi di Render, sehingga aplikasi tidak bisa connect ke Firebase Realtime Database.

## Solusi: Tambahkan Environment Variables

### Step 1: Buka Render Dashboard

1. Login ke https://dashboard.render.com
2. Pilih web service "Well Intervention Field-Ready Digital Guide"
3. Klik tab **"Environment"** di menu sebelah kiri

### Step 2: Tambahkan Firebase Environment Variables

Klik **"Add Environment Variable"** dan tambahkan satu per satu:

```bash
FIREBASE_API_KEY=AIzaSyB2Kx60bD58HQ5JqwbqjYaALzEhHQIPbkw
FIREBASE_AUTH_DOMAIN=wi-field-ready-digital-guide.firebaseapp.com
FIREBASE_DATABASE_URL=https://wi-field-ready-digital-guide-default-rtdb.asia-southeast1.firebasedatabase.app
FIREBASE_PROJECT_ID=wi-field-ready-digital-guide
FIREBASE_STORAGE_BUCKET=wi-field-ready-digital-guide.firebasestorage.app
FIREBASE_MESSAGING_SENDER_ID=51623643193
FIREBASE_APP_ID=1:51623643193:web:6f244103625708e57a25e8
```

**Atau cara cepat:**
1. Klik tombol **"Add from .env"**
2. Copy-paste semua environment variables di atas sekaligus
3. Klik "Add Variables"

### Step 3: Redeploy Aplikasi

Setelah menambahkan environment variables:

1. Klik tab **"Manual Deploy"**
2. Pilih **"Clear build cache & deploy"**
3. Tunggu proses deploy selesai (~5-10 menit)

### Step 4: Verifikasi Firebase Berfungsi

#### Di Browser (Render Website):
1. Buka website Render Anda
2. Tekan **F12** (buka Developer Console)
3. Lihat tab "Console"
4. Seharusnya muncul log:
   - ✅ `🔥 Firebase initialized successfully!`
   - ✅ `Firebase ready, syncing...`
   - ✅ `Article X synced to Firebase: Y views`

#### Yang TIDAK boleh muncul:
- ❌ "Firebase credentials not configured"
- ❌ "Firebase initialization timeout"
- ❌ "Uncaught ReferenceError"

### Step 5: Test Real-Time Counter

1. Buka halaman artikel di Render
2. View count seharusnya muncul
3. Buka artikel yang sama di tab browser lain
4. View count akan update secara real-time

## Troubleshooting

### Masalah: Firebase masih error setelah tambah environment variables

**Solusi:**
1. Pastikan TIDAK ada spasi di awal/akhir value environment variable
2. Check logs di Render: Tab "Logs" → cari error Firebase
3. Clear browser cache dan hard refresh (Ctrl+F5)

### Masalah: Environment variables hilang setelah redeploy

**Solusi:**
Environment variables di Render bersifat persistent, tapi pastikan:
1. Jangan gunakan mode "Preview" environment - gunakan "Production"
2. Verifikasi di tab "Environment" bahwa semua variables masih ada

### Masalah: "module is not defined" error

**Solusi:**
Error ini muncul karena Firebase SDK dimuat sebelum environment variables diset. Sudah diperbaiki di `application.html.erb` dengan:
```erb
<% if ENV['FIREBASE_API_KEY'].present? %>
  // Firebase config here
<% else %>
  console.warn('Firebase credentials not configured');
<% end %>
```

### Masalah: View count tidak sinkron antara lokal dan Render

**Solusi:**
Ini normal! Lokal dan production menggunakan Firebase Database yang berbeda. Untuk sinkronkan:
1. Pastikan kedua environment menggunakan FIREBASE_DATABASE_URL yang sama
2. Atau terima bahwa data dev dan production terpisah (recommended)

## Firebase Database Rules

Pastikan Firebase Realtime Database Rules sudah diset di Firebase Console:

```json
{
  "rules": {
    "article_views": {
      ".read": true,
      ".write": true
    }
  }
}
```

Cara setting:
1. Buka Firebase Console: https://console.firebase.google.com
2. Pilih project "wi-field-ready-digital-guide"
3. Realtime Database → Rules tab
4. Paste rules di atas
5. Publish

## Checklist

Sebelum deploy, pastikan:
- ✅ Semua 7 environment variables Firebase sudah ditambahkan
- ✅ `bin/render-build.sh` berisi `bundle exec rake db:seed`
- ✅ Firebase Database Rules sudah diset di Firebase Console
- ✅ Browser console tidak ada error Firebase

## Verifikasi Akhir

Setelah semua selesai, test:
1. ✅ Homepage menampilkan popular articles dengan view count
2. ✅ Buka artikel → view count bertambah
3. ✅ Browser console menampilkan "Firebase initialized successfully"
4. ✅ Tidak ada error di Render logs
5. ✅ Real-time update berfungsi (buka 2 tab, view count sinkron)

---

**Status**: Jika semua checklist ✅, Firebase sudah berfungsi dengan sempurna di Render! 🎉

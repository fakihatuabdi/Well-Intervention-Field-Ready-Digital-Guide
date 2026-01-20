# Firebase View Counter Reset Guide

Ada **3 cara** untuk reset Firebase view counter ke 0:

---

## 📋 Opsi 1: Reset via Firebase Console (Termudah)

### Langkah-langkah:

1. **Buka Firebase Console**
   - URL: https://console.firebase.google.com
   - Login dengan akun Firebase Anda

2. **Pilih Project**
   - Project: `wi-field-ready-digital-guide`

3. **Buka Realtime Database**
   - Di menu sebelah kiri, klik **"Realtime Database"**
   - Atau langsung ke: https://console.firebase.google.com/project/wi-field-ready-digital-guide/database/wi-field-ready-digital-guide-default-rtdb/data

4. **Delete View Counter Data**
   
   **Opsi A - Reset Semua:**
   - Cari node `article_views`
   - Klik icon **⋮** (tiga titik vertikal) di sebelah `article_views`
   - Pilih **"Delete"**
   - Confirm deletion
   
   **Opsi B - Reset Per Artikel:**
   - Expand node `article_views`
   - Pilih artikel ID yang ingin di-reset (misal: `1`, `2`, `3`)
   - Klik icon **⋮** dan pilih **"Delete"**

5. **Selesai!**
   - View counter akan otomatis mulai dari 0 lagi
   - Tidak perlu restart aplikasi

---

## 📋 Opsi 2: Reset via Rake Task

### Reset Rails Database View Count:

```bash
rake firebase:reset_rails_views
```

**Ini akan:**
- ✅ Reset `view_count` di database Rails ke 0
- ❌ **TIDAK** reset Firebase Realtime Database
- Bagus untuk sinkronisasi Rails database saja

### Lihat Firebase Paths:

```bash
rake firebase:reset_views
```

**Ini akan menampilkan:**
- Daftar semua article IDs
- Path Firebase yang perlu di-delete
- Panduan manual untuk reset di Firebase Console

---

## 📋 Opsi 3: Reset via Firebase Rules (Advanced)

Tambahkan function untuk reset semua counters:

### 1. Buat file script HTML untuk reset:

Simpan sebagai `firebase_reset.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Firebase Reset Tool</title>
  <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-database-compat.js"></script>
</head>
<body>
  <h1>Firebase View Counter Reset</h1>
  <button onclick="resetAllViews()">Reset All View Counters</button>
  <div id="status"></div>

  <script>
    // Firebase Config
    const firebaseConfig = {
      apiKey: "AIzaSyB2Kx60bD58HQ5JqwbqjYaALzEhHQIPbkw",
      authDomain: "wi-field-ready-digital-guide.firebaseapp.com",
      databaseURL: "https://wi-field-ready-digital-guide-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "wi-field-ready-digital-guide",
      storageBucket: "wi-field-ready-digital-guide.firebasestorage.app",
      messagingSenderId: "51623643193",
      appId: "1:51623643193:web:6f244103625708e57a25e8"
    };

    firebase.initializeApp(firebaseConfig);
    const database = firebase.database();

    async function resetAllViews() {
      const status = document.getElementById('status');
      status.innerHTML = 'Resetting...';
      
      try {
        await database.ref('article_views').remove();
        status.innerHTML = '<strong style="color:green">✅ All view counters reset to 0!</strong>';
      } catch (error) {
        status.innerHTML = '<strong style="color:red">❌ Error: ' + error.message + '</strong>';
      }
    }
  </script>
</body>
</html>
```

### 2. Cara menggunakan:
- Buka file `firebase_reset.html` di browser
- Klik tombol "Reset All View Counters"
- Selesai!

---

## 🔄 Opsi 4: Reset Otomatis via Schedule (Advanced)

Jika ingin reset berkala (misalnya setiap bulan), Anda bisa:

1. **Setup Firebase Cloud Functions:**
```javascript
exports.resetMonthlyViews = functions.pubsub
  .schedule('0 0 1 * *') // Setiap tanggal 1 jam 00:00
  .onRun(async (context) => {
    await admin.database().ref('article_views').remove();
    console.log('Monthly view reset completed');
  });
```

2. **Deploy ke Firebase:**
```bash
firebase deploy --only functions
```

---

## ✅ Rekomendasi

**Untuk reset cepat dan mudah:**
→ **Gunakan Opsi 1** (Firebase Console)

**Untuk reset berkala:**
→ Simpan file `firebase_reset.html` dan gunakan saat diperlukan

**Untuk sinkronisasi Rails database:**
→ Gunakan `rake firebase:reset_rails_views`

---

## ⚠️ Catatan Penting

1. **Reset Firebase ≠ Reset Rails Database**
   - Firebase view counter terpisah dari database Rails
   - Jika ingin reset keduanya, lakukan kedua langkah:
     ```bash
     rake firebase:reset_rails_views  # Reset Rails
     # Lalu reset Firebase via Console
     ```

2. **Data yang di-delete permanen**
   - Tidak ada undo setelah delete
   - View count akan mulai dari 0 lagi

3. **Real-time Update**
   - Setelah reset, semua user yang membuka halaman akan melihat 0 views
   - Counter akan mulai naik lagi dari 0

4. **Tidak perlu restart aplikasi**
   - Reset Firebase langsung terlihat oleh semua user
   - No deployment needed

---

## 🎯 Contoh Penggunaan

### Scenario: Reset semua counter sebelum launch official

```bash
# Step 1: Reset Rails database
rake firebase:reset_rails_views

# Step 2: Reset Firebase
# Buka Firebase Console → Realtime Database
# Delete node 'article_views'

# Step 3: Verify
# Buka aplikasi, view counter semua 0
```

Selesai! 🎉

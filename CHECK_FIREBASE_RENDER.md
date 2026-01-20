# Cara Cek Firebase di Render

## 🔍 Quick Check

### 1. Buka Aplikasi Render di Browser
URL: https://well-intervention-field-ready-digital-guide.onrender.com

### 2. Buka Browser Console (F12)
Sebelum mengakses artikel, jalankan:

```javascript
// Cek Firebase loaded
console.log('Firebase:', typeof firebase);
// Expected: "object" (jika loaded) atau "undefined" (jika tidak)

// Cek Firebase initialized
if (typeof firebase !== 'undefined') {
  console.log('Firebase apps:', firebase.apps.length);
  console.log('Database:', firebase.database ? 'Ready' : 'Not loaded');
}

// Cek View Counter
console.log('View Counter:', typeof firebaseViewCounter);
// Expected: "object" (jika loaded)

// Test connection
if (typeof firebase !== 'undefined' && firebase.database) {
  firebase.database().ref('.info/connected').on('value', (snap) => {
    console.log('🔥 Firebase Connected:', snap.val());
  });
}
```

### 3. Akses Salah Satu Artikel
Klik artikel apapun dan lihat console log:

**✅ FIREBASE WORKING:**
```
🔥 Firebase initialized successfully!
Firebase View Counter initialized
Article 1 view incremented via Firebase
```

**⚠️ RAILS FALLBACK:**
```
Firebase not initialized. View counting will use fallback mode.
Firebase not available, using Rails backend for view count
View count updated via Rails: 5
```

---

## 🔧 Troubleshooting

### Issue 1: Firebase SDK Tidak Load

**Symptom:**
```javascript
typeof firebase // "undefined"
```

**Cause:** Asset pipeline atau CDN issue

**Solution:** Sudah menggunakan CDN langsung di layout, seharusnya tidak ada masalah.

---

### Issue 2: Firebase Database Rules

**Symptom:**
```
Error incrementing view: Error: Permission denied
```

**Cause:** Firebase Rules tidak mengizinkan write

**Solution - Update Firebase Rules:**

1. Buka Firebase Console
2. Go to **Realtime Database** → **Rules** tab
3. Update rules menjadi:

```json
{
  "rules": {
    "article_views": {
      "$articleId": {
        ".read": true,
        ".write": true
      }
    }
  }
}
```

4. Klik **Publish**

⚠️ **Catatan:** Rules di atas untuk testing. Untuk production, gunakan rules yang lebih ketat.

---

### Issue 3: CORS Issue

**Symptom:**
```
CORS policy: No 'Access-Control-Allow-Origin' header
```

**Cause:** Firebase belum whitelist domain Render

**Solution:**

1. Firebase Console → Project Settings
2. Scroll ke **Authorized domains**
3. Tambahkan:
   - `well-intervention-field-ready-digital-guide.onrender.com`
4. Save

---

## 🎯 Manual Test Firebase

Jalankan di Browser Console (saat di halaman Render):

```javascript
// Manual increment test
if (typeof firebaseViewCounter !== 'undefined') {
  firebaseViewCounter.incrementArticleView(1)
    .then(() => console.log('✅ Firebase increment SUCCESS'))
    .catch(err => console.error('❌ Firebase increment FAILED:', err));
}

// Manual watch test
if (typeof firebaseViewCounter !== 'undefined' && firebaseViewCounter.isInitialized) {
  firebaseViewCounter.watchArticleViews(1, (count) => {
    console.log('📊 Real-time view count:', count);
  });
}
```

---

## 📊 Expected Results

### Firebase Working ✅
- Console: "🔥 Firebase initialized successfully!"
- Console: "Article X view incremented via Firebase"
- Firebase Console: Node `article_views` muncul dengan data
- View counter real-time sync antar browser

### Rails Fallback ⚠️
- Console: "Firebase not available, using Rails backend"
- Firebase Console: Masih null/kosong
- View counter hanya update setelah refresh page
- Counter disimpan di Rails database saja

---

## ✅ Recommended Check List

- [ ] Buka aplikasi Render di browser
- [ ] F12 → Console tab
- [ ] Cek: `typeof firebase` = "object"
- [ ] Cek: `typeof firebaseViewCounter` = "object"
- [ ] Akses salah satu artikel
- [ ] Lihat log: "Article X view incremented via Firebase"
- [ ] Buka Firebase Console
- [ ] Refresh database view
- [ ] Node `article_views` harus muncul!

Jika semua ✅, Firebase di Render sudah WORKING! 🎉

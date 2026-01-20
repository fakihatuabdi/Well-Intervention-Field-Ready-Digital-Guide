# Firebase Counter Debug Guide

## 🔍 Cara Debug Counter yang Tidak Berjalan

### Step 1: Buka Browser Console (F12)

Saat Anda membuka artikel di Render, lihat Console tab dan cari log berikut:

**✅ Log yang BAIK (Firebase Working):**
```javascript
🔥 Firebase initialized successfully!
Firebase View Counter initialized
Initializing view counter for article 1
Firebase initialized: true
Current view count from Firebase: 0
Incrementing view count...
Article 1 view incremented via Firebase
Real-time update - view count: 1
```

**❌ Log yang BERMASALAH:**
```javascript
Firebase not initialized. View counting will use fallback mode.
// atau
firebaseViewCounter not found, retrying in 500ms...
// atau
Error incrementing view: Permission denied
```

---

## 🛠️ Troubleshooting

### Problem 1: Counter Tetap di 0

**Symptom:** Counter tidak berubah dari 0 meskipun artikel diakses

**Debug Steps:**

1. **Cek Console Log di Browser:**
   - F12 → Console tab
   - Refresh halaman artikel
   - Lihat apakah ada error

2. **Cek Firebase Console:**
   - Buka https://console.firebase.google.com
   - Realtime Database
   - Lihat apakah node `article_views` muncul

3. **Test Manual di Console:**
   ```javascript
   // Cek Firebase loaded
   console.log('Firebase:', typeof firebase);
   // Expected: "object"
   
   // Cek View Counter
   console.log('View Counter:', typeof firebaseViewCounter);
   // Expected: "object"
   
   // Cek initialized
   if (firebaseViewCounter) {
     console.log('Initialized:', firebaseViewCounter.isInitialized);
     // Expected: true
   }
   ```

4. **Test Manual Increment:**
   ```javascript
   // Test increment article 1
   firebaseViewCounter.incrementArticleView(1);
   // Lihat log di console
   ```

---

### Problem 2: "Permission Denied" Error

**Symptom:** Console menampilkan: `Error: Permission denied`

**Solution - Update Firebase Rules:**

1. Buka Firebase Console
2. Realtime Database → **Rules** tab
3. Update rules:

```json
{
  "rules": {
    ".read": "auth == null",
    ".write": "auth == null",
    "article_views": {
      "$articleId": {
        ".read": true,
        ".write": true,
        ".validate": "newData.isNumber()"
      }
    }
  }
}
```

4. Klik **Publish**
5. Refresh aplikasi dan test lagi

---

### Problem 3: Firebase SDK Tidak Load

**Symptom:** `typeof firebase === 'undefined'`

**Possible Causes:**
- CDN blocked
- Network issue
- Ad blocker blocking Firebase

**Solution:**

1. **Disable Ad Blocker** untuk site Render
2. **Check Network Tab:**
   - F12 → Network tab
   - Filter: `firebase`
   - Cari request ke `gstatic.com/firebasejs`
   - Status harus 200 (OK)

3. **Test CDN:**
   Buka di tab baru:
   ```
   https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js
   ```
   Harus download file JavaScript

---

### Problem 4: Timing Issue

**Symptom:** Log menampilkan "Waiting for firebaseViewCounter..."

**Solution:** Script sekarang sudah ada retry logic. Tunggu beberapa detik dan cek apakah ada log:
```
Initializing view counter for article X
```

Jika masih tidak muncul setelah 5 detik, ada masalah dengan import JavaScript.

---

## ✅ Quick Fix Checklist

Jalankan test ini di Browser Console (F12):

```javascript
// === TEST 1: Firebase SDK ===
console.log('1. Firebase SDK:', typeof firebase !== 'undefined' ? '✅ Loaded' : '❌ Not Loaded');

// === TEST 2: Firebase Database ===
if (typeof firebase !== 'undefined') {
  console.log('2. Firebase Database:', firebase.database ? '✅ Available' : '❌ Not Available');
}

// === TEST 3: View Counter Class ===
console.log('3. View Counter:', typeof firebaseViewCounter !== 'undefined' ? '✅ Loaded' : '❌ Not Loaded');

// === TEST 4: Initialized Status ===
if (typeof firebaseViewCounter !== 'undefined') {
  console.log('4. Initialized:', firebaseViewCounter.isInitialized ? '✅ Yes' : '❌ No');
}

// === TEST 5: Connection Test ===
if (typeof firebase !== 'undefined' && firebase.database) {
  firebase.database().ref('.info/connected').once('value', (snap) => {
    console.log('5. Firebase Connected:', snap.val() ? '✅ Yes' : '❌ No');
  });
}

// === TEST 6: Manual Increment ===
if (typeof firebaseViewCounter !== 'undefined') {
  console.log('6. Testing increment...');
  firebaseViewCounter.incrementArticleView(1)
    .then(() => console.log('   ✅ Increment SUCCESS'))
    .catch(err => console.error('   ❌ Increment FAILED:', err));
}

// === TEST 7: Read Test ===
if (typeof firebaseViewCounter !== 'undefined' && firebaseViewCounter.isInitialized) {
  console.log('7. Testing read...');
  firebaseViewCounter.getArticleViews(1)
    .then(count => console.log('   ✅ Current count:', count))
    .catch(err => console.error('   ❌ Read FAILED:', err));
}
```

**Expected Output:**
```
1. Firebase SDK: ✅ Loaded
2. Firebase Database: ✅ Available
3. View Counter: ✅ Loaded
4. Initialized: ✅ Yes
5. Firebase Connected: ✅ Yes
6. Testing increment...
   ✅ Increment SUCCESS
7. Testing read...
   ✅ Current count: 1
```

---

## 🎯 Common Solutions Summary

| Problem | Solution |
|---------|----------|
| Counter stays at 0 | Check Console for errors, verify Firebase Rules |
| "Permission denied" | Update Firebase Database Rules |
| Firebase not loaded | Check Network tab, disable ad blocker |
| Timing issues | Wait for retry logic (up to 5 seconds) |
| Rules issue | Set `.write: true` for `article_views` node |

---

## 📞 Still Not Working?

If counter still doesn't work after all checks:

1. **Copy ALL console logs** (F12 → Console → Right click → Save as...)
2. **Screenshot Firebase Console** showing database state
3. **Screenshot Network tab** showing Firebase requests
4. Share untuk analysis lebih detail

---

## 🔄 Force Refresh

Setelah deploy baru:
- **Windows/Linux:** Ctrl + Shift + R
- **Mac:** Cmd + Shift + R
- Atau clear browser cache untuk domain Render

Ini memastikan JavaScript terbaru ter-load.

# Testing View Counter Real-Time

## Cara Test View Counter:

### 1. Test Lokal (Tanpa Firebase)
1. Buka aplikasi di browser: http://localhost:3000
2. Lihat "Popular Articles" di home page - catat jumlah views
3. Klik salah satu artikel untuk membuka halaman detail
4. Tunggu 1-2 detik
5. Kembali ke home page (refresh)
6. Jumlah views artikel tersebut harus bertambah +1

### 2. Test Real-Time (Dengan Firebase)
Jika Firebase sudah dikonfigurasi:

1. **Buka 2 Browser/Tab:**
   - Tab 1: Home page
   - Tab 2: Artikel detail page

2. **Test Scenario:**
   - Di Tab 1: Perhatikan jumlah views di "Popular Articles"
   - Di Tab 2: Buka artikel (views akan auto increment)
   - Di Tab 1: Angka views akan update otomatis TANPA refresh!

3. **Expected Behavior:**
   - View count update secara real-time di semua tab yang terbuka
   - Animasi smooth saat angka berubah
   - Tidak ada delay lebih dari 1-2 detik

### 3. Verifikasi Database
```bash
rails console
```

```ruby
# Cek artikel dengan views tertinggi
Article.order(view_count: :desc).limit(5).pluck(:title, :view_count)

# Increment manual (untuk testing)
article = Article.first
article.increment_view_count
article.reload.view_count
```

### 4. Cara Kerja Sistem:

**Dengan Firebase (Real-Time):**
1. User buka artikel → JavaScript call `firebaseViewCounter.incrementArticleView()`
2. Firebase Realtime Database update counter
3. Semua listener di home page & artikel page auto-update
4. Rails backend juga di-update via AJAX fallback

**Tanpa Firebase (Fallback):**
1. User buka artikel → JavaScript call Rails endpoint
2. Rails increment `article.view_count` di database
3. Response JSON dengan view_count terbaru
4. JavaScript update tampilan
5. User harus refresh home page untuk lihat perubahan

### 5. Check Console Logs

**Buka Browser Developer Tools (F12):**

Dengan Firebase:
```
Firebase View Counter initialized
Article 1 view incremented via Firebase
```

Tanpa Firebase:
```
Firebase not initialized. View counting will use fallback mode.
Firebase not available, using Rails backend for view count
View count updated via Rails: 123
```

## Troubleshooting:

### Views tidak bertambah?
- Check browser console untuk error
- Pastikan JavaScript enabled
- Cek Rails logs: `tail -f log/development.log`

### Real-time tidak bekerja?
- Firebase belum dikonfigurasi (normal - fallback ke Rails)
- Check Firebase credentials
- Lihat console untuk Firebase errors

### Double counting?
- Clear browser cache
- Restart Rails server
- Check ArticlesController - pastikan tidak ada double increment

## File yang Terlibat:

- `/app/controllers/articles_controller.rb` - Backend increment logic
- `/app/models/article.rb` - View count model & scope
- `/app/views/articles/show.html.erb` - Artikel page dengan increment trigger
- `/app/views/home/index.html.erb` - Popular articles dengan real-time listener
- `/app/javascript/firebase_analytics.js` - Firebase & view counter logic

# Firebase Real-Time Analytics Integration Guide

## 📋 Tujuan
Mengintegrasikan Firebase Analytics untuk tracking view count artikel secara real-time.

---

## 🔧 STEP 1: Setup Firebase Project

### 1.1 Buat Firebase Project
1. Buka https://console.firebase.google.com/
2. Klik **"Add project"** atau **"Tambah project"**
3. Masukkan nama project: `rails-handbook-analytics`
4. Pilih **Enable Google Analytics** (opsional, tapi direkomendasikan)
5. Klik **Create project**

### 1.2 Daftarkan Web App
1. Di Firebase Console, pilih project Anda
2. Klik icon **Web** (</>) untuk menambahkan web app
3. Masukkan nickname: `Rails Handbook Web`
4. Centang **"Also set up Firebase Hosting"** (opsional)
5. Klik **Register app**
6. **SIMPAN** konfigurasi yang muncul (firebaseConfig object)

Contoh konfigurasi:
```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:xxxxxxxxxxxxx"
};
```

---

## 🔧 STEP 2: Pilih Firebase Service

### Opsi A: Firebase Realtime Database (Rekomendasi untuk view count)
**Keuntungan:**
- ✅ Real-time sync otomatis
- ✅ Offline support
- ✅ Simple struktur data (JSON tree)
- ✅ Gratis untuk traffic kecil-menengah

**Setup:**
1. Di Firebase Console → **Build** → **Realtime Database**
2. Klik **Create Database**
3. Pilih lokasi server: `Singapore` atau `United States (us-central1)`
4. Pilih mode: **Start in test mode** (untuk development)
5. Klik **Enable**

**Security Rules (untuk production, ubah nanti):**
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

### Opsi B: Cloud Firestore (Alternatif, lebih scalable)
**Keuntungan:**
- ✅ Better querying
- ✅ More structured data
- ✅ Better for complex apps

**Setup:**
1. Di Firebase Console → **Build** → **Firestore Database**
2. Klik **Create database**
3. Pilih mode: **Start in test mode**
4. Pilih lokasi: `asia-southeast1` (Singapore)
5. Klik **Enable**

---

## 🔧 STEP 3: Instalasi di Rails App

### 3.1 Tambahkan Firebase SDK ke Layout

Edit file: `app/views/layouts/application.html.erb`

Tambahkan sebelum `</head>`:

```erb
<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-database-compat.js"></script>

<script>
  // Firebase Configuration
  const firebaseConfig = {
    apiKey: "<%= ENV['FIREBASE_API_KEY'] %>",
    authDomain: "<%= ENV['FIREBASE_AUTH_DOMAIN'] %>",
    databaseURL: "<%= ENV['FIREBASE_DATABASE_URL'] %>",
    projectId: "<%= ENV['FIREBASE_PROJECT_ID'] %>",
    storageBucket: "<%= ENV['FIREBASE_STORAGE_BUCKET'] %>",
    messagingSenderId: "<%= ENV['FIREBASE_MESSAGING_SENDER_ID'] %>",
    appId: "<%= ENV['FIREBASE_APP_ID'] %>"
  };

  // Initialize Firebase
  if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
  }
  const database = firebase.database();
</script>
```

### 3.2 Setup Environment Variables

Buat/edit file: `.env` (jangan commit ke Git!)

```bash
# Firebase Configuration
FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXX
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_STORAGE_BUCKET=your-project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=123456789
FIREBASE_APP_ID=1:123456789:web:xxxxxxxxxxxxx
```

Tambahkan ke `.gitignore`:
```
.env
.env.local
```

### 3.3 Install Dotenv Gem

Edit `Gemfile`, tambahkan:
```ruby
gem 'dotenv-rails', groups: [:development, :test]
```

Jalankan:
```bash
bundle install
```

---

## 🔧 STEP 4: Implementasi Real-Time View Counter

### 4.1 Buat JavaScript Helper

Buat file: `app/javascript/firebase_analytics.js`

```javascript
// Firebase Real-Time View Counter
class FirebaseViewCounter {
  constructor() {
    this.database = firebase.database();
  }

  // Increment view count untuk artikel
  async incrementArticleView(articleId) {
    const viewRef = this.database.ref(`article_views/${articleId}`);
    
    try {
      await viewRef.transaction((currentViews) => {
        return (currentViews || 0) + 1;
      });
      console.log(`Article ${articleId} view incremented`);
    } catch (error) {
      console.error('Error incrementing view:', error);
    }
  }

  // Listen untuk perubahan view count real-time
  watchArticleViews(articleId, callback) {
    const viewRef = this.database.ref(`article_views/${articleId}`);
    
    viewRef.on('value', (snapshot) => {
      const viewCount = snapshot.val() || 0;
      callback(viewCount);
    });
  }

  // Unsubscribe dari listener
  unwatchArticleViews(articleId) {
    const viewRef = this.database.ref(`article_views/${articleId}`);
    viewRef.off();
  }

  // Get view count sekali (tidak real-time)
  async getArticleViews(articleId) {
    const viewRef = this.database.ref(`article_views/${articleId}`);
    const snapshot = await viewRef.once('value');
    return snapshot.val() || 0;
  }

  // Batch get multiple article views
  async getMultipleArticleViews(articleIds) {
    const promises = articleIds.map(id => this.getArticleViews(id));
    return await Promise.all(promises);
  }
}

// Export global instance
window.firebaseViewCounter = new FirebaseViewCounter();
```

### 4.2 Import di Application.js

Edit `app/javascript/application.js`:

```javascript
// Existing imports...
import "./firebase_analytics"
```

### 4.3 Update Article Show Page

Edit `app/views/articles/show.html.erb`, tambahkan di bagian bawah:

```erb
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const articleId = <%= @article.id %>;
    const viewCountElement = document.getElementById('view-count-<%= @article.id %>');
    
    // Increment view saat halaman dibuka
    firebaseViewCounter.incrementArticleView(articleId);
    
    // Listen untuk update real-time
    firebaseViewCounter.watchArticleViews(articleId, (count) => {
      if (viewCountElement) {
        viewCountElement.textContent = count;
      }
    });
    
    // Cleanup saat halaman ditutup
    window.addEventListener('beforeunload', () => {
      firebaseViewCounter.unwatchArticleViews(articleId);
    });
  });
</script>
```

### 4.4 Update Home Page (Popular Articles)

Edit `app/views/home/index.html.erb`, tambahkan sebelum `</body>`:

```erb
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const popularArticles = <%= raw @popular_articles.pluck(:id).to_json %>;
    
    // Watch semua popular articles untuk update real-time
    popularArticles.forEach(articleId => {
      firebaseViewCounter.watchArticleViews(articleId, (count) => {
        const element = document.getElementById(`view-count-${articleId}`);
        if (element) {
          element.textContent = count;
        }
      });
    });
    
    // Cleanup saat halaman ditutup
    window.addEventListener('beforeunload', () => {
      popularArticles.forEach(articleId => {
        firebaseViewCounter.unwatchArticleViews(articleId);
      });
    });
  });
</script>
```

---

## 🔧 STEP 5: Sync Firebase dengan Database (Opsional)

Jika Anda ingin sync view count dari Firebase ke Rails database secara berkala:

### 5.1 Buat Rake Task

Buat file: `lib/tasks/firebase_sync.rake`

```ruby
namespace :firebase do
  desc "Sync view counts from Firebase to database"
  task sync_views: :environment do
    require 'net/http'
    require 'json'
    
    firebase_url = ENV['FIREBASE_DATABASE_URL']
    
    Article.find_each do |article|
      begin
        uri = URI("#{firebase_url}/article_views/#{article.id}.json")
        response = Net::HTTP.get(uri)
        firebase_count = JSON.parse(response).to_i
        
        if firebase_count > article.view_count
          article.update_column(:view_count, firebase_count)
          puts "Synced Article ##{article.id}: #{firebase_count} views"
        end
      rescue => e
        puts "Error syncing Article ##{article.id}: #{e.message}"
      end
    end
    
    puts "Sync completed!"
  end
end
```

### 5.2 Setup Cron Job (dengan gem whenever)

Tambahkan ke `Gemfile`:
```ruby
gem 'whenever', require: false
```

Install:
```bash
bundle install
bundle exec wheneverize .
```

Edit `config/schedule.rb`:
```ruby
every 1.hour do
  rake "firebase:sync_views"
end
```

---

## 🔧 STEP 6: Testing

### 6.1 Test di Browser Console

Buka artikel di browser, jalankan di console:

```javascript
// Test increment
firebaseViewCounter.incrementArticleView(1);

// Test get views
firebaseViewCounter.getArticleViews(1).then(count => {
  console.log('Views:', count);
});

// Test watch (real-time)
firebaseViewCounter.watchArticleViews(1, (count) => {
  console.log('Real-time count:', count);
});
```

### 6.2 Verifikasi di Firebase Console

1. Buka Firebase Console
2. Go to **Realtime Database**
3. Lihat struktur data:
```
article_views/
  ├── 1: 42
  ├── 2: 15
  └── 3: 28
```

---

## 🔧 STEP 7: Production Security Rules

Sebelum production, update Firebase Rules:

### Realtime Database Rules:
```json
{
  "rules": {
    "article_views": {
      "$articleId": {
        ".read": true,
        ".write": "auth == null || auth.uid != null"
      }
    }
  }
}
```

### Tambahan: Rate Limiting
```json
{
  "rules": {
    "article_views": {
      "$articleId": {
        ".read": true,
        ".write": "(!data.exists() || data.val() < newData.val()) && 
                   (newData.val() - data.val() == 1)"
      }
    }
  }
}
```

---

## 📊 Analytics Dashboard (Bonus)

### Buat Admin Dashboard untuk Melihat Stats

Buat route baru di `config/routes.rb`:
```ruby
get 'admin/analytics', to: 'admin#analytics'
```

Buat controller `app/controllers/admin_controller.rb`:
```ruby
class AdminController < ApplicationController
  def analytics
    @articles = Article.published.order(view_count: :desc).limit(20)
  end
end
```

Buat view `app/views/admin/analytics.html.erb`:
```erb
<h1>Real-Time Analytics Dashboard</h1>

<div id="analytics-dashboard">
  <% @articles.each do |article| %>
    <div>
      <h3><%= article.title %></h3>
      <p>Views: <span id="firebase-view-<%= article.id %>">Loading...</span></p>
    </div>
  <% end %>
</div>

<script>
  const articles = <%= raw @articles.pluck(:id).to_json %>;
  
  articles.forEach(articleId => {
    firebaseViewCounter.watchArticleViews(articleId, (count) => {
      document.getElementById(`firebase-view-${articleId}`).textContent = count;
    });
  });
</script>
```

---

## 🎯 Kesimpulan

**Keuntungan Firebase Realtime Database:**
✅ View count update otomatis tanpa refresh
✅ Semua user melihat angka yang sama secara real-time
✅ Mengurangi load ke Rails database
✅ Offline support
✅ Gratis untuk traffic kecil-menengah (50K concurrent connections)

**Next Steps:**
1. Setup Firebase project
2. Install Firebase SDK
3. Implement JavaScript counter
4. Test di browser
5. Deploy ke production

---

## 📚 Resources

- Firebase Realtime Database Docs: https://firebase.google.com/docs/database
- Firebase Web SDK: https://firebase.google.com/docs/web/setup
- Firebase Security Rules: https://firebase.google.com/docs/database/security

---

**Dibuat pada:** January 15, 2026
**Untuk:** Rails Handbook Application
**Author:** GitHub Copilot

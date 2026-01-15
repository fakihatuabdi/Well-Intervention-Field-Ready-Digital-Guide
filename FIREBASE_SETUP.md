# Firebase Integration Guide

## Setup Firebase for Real-Time View Counter

Panduan ini menjelaskan bagaimana mengintegrasikan Firebase untuk real-time view counter pada artikel.

### Step 1: Create Firebase Project

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Klik "Add Project"
3. Masukkan nama project: `well-intervention-guide`
4. Ikuti setup wizard hingga selesai

### Step 2: Setup Firebase Realtime Database

1. Di Firebase Console, pilih project Anda
2. Klik "Realtime Database" di menu sebelah kiri
3. Klik "Create Database"
4. Pilih lokasi server (recommend: asia-southeast1)
5. Mulai dengan "test mode" untuk development

### Step 3: Get Firebase Configuration

1. Di Firebase Console, klik gear icon > Project Settings
2. Scroll ke "Your apps" section
3. Klik icon Web (</>)
4. Register app dengan nickname "well-intervention-web"
5. Copy configuration object

### Step 4: Add Firebase to Application

#### Install Firebase SDK

Add to `app/views/layouts/application.html.erb` sebelum closing `</body>` tag:

```erb
<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-database.js"></script>

<script>
  // Your Firebase configuration
  const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    databaseURL: "https://YOUR_PROJECT_ID.firebaseio.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
  };

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  const database = firebase.database();
</script>
```

### Step 5: Implement Real-Time View Counter

#### Update Article Show Page

Add to `app/views/articles/show.html.erb`:

```erb
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const articleId = <%= @article.id %>;
    const viewCountRef = database.ref('articles/' + articleId + '/views');
    
    // Increment view count
    viewCountRef.transaction(function(currentViews) {
      return (currentViews || 0) + 1;
    });
    
    // Listen for real-time updates
    viewCountRef.on('value', function(snapshot) {
      const views = snapshot.val() || 0;
      document.getElementById('view-count').textContent = views;
    });
  });
</script>
```

#### Update Home Page Popular Articles

Add to `app/views/home/index.html.erb`:

```erb
<script>
  document.addEventListener('DOMContentLoaded', function() {
    <% @popular_articles.each do |article| %>
      const viewCountRef<%= article.id %> = database.ref('articles/<%= article.id %>/views');
      
      viewCountRef<%= article.id %>.on('value', function(snapshot) {
        const views = snapshot.val() || 0;
        const element = document.getElementById('view-count-<%= article.id %>');
        if (element) {
          element.textContent = views;
        }
      });
    <% end %>
  });
</script>
```

### Step 6: Sync Firebase with Database

Create a background job to sync Firebase counts with Rails database:

```ruby
# app/jobs/sync_view_counts_job.rb
class SyncViewCountsJob < ApplicationJob
  queue_as :default

  def perform
    # This job will sync Firebase counts back to database
    # Run this periodically (e.g., every hour)
    
    Article.find_each do |article|
      # Fetch count from Firebase and update database
      # Implementation will depend on your Firebase SDK choice
    end
  end
end
```

### Step 7: Database Rules

Set Firebase Realtime Database rules:

```json
{
  "rules": {
    "articles": {
      "$articleId": {
        "views": {
          ".read": true,
          ".write": true,
          ".validate": "newData.isNumber()"
        }
      }
    }
  }
}
```

### Step 8: Security Considerations

1. **API Key Rotation**: Regularly rotate your Firebase API keys
2. **Database Rules**: Set proper read/write rules for production
3. **Rate Limiting**: Implement rate limiting to prevent abuse
4. **Analytics**: Monitor usage through Firebase Analytics

### Optional: Use Firebase Analytics

```erb
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-analytics.js"></script>

<script>
  const analytics = firebase.analytics();
  
  // Log events
  analytics.logEvent('article_view', {
    article_id: <%= @article.id %>,
    article_title: '<%= @article.title %>'
  });
</script>
```

### Testing

1. Open article in multiple browsers/devices
2. Verify view count increments
3. Check Firebase Console > Realtime Database for data
4. Ensure real-time updates work across sessions

### Production Deployment

1. Switch Firebase Database rules to production mode
2. Use environment variables for Firebase config
3. Setup automated backups
4. Monitor Firebase usage and billing

### Troubleshooting

**Issue: View count not updating**
- Check browser console for errors
- Verify Firebase configuration
- Check database rules

**Issue: Too many reads/writes**
- Implement caching
- Batch updates
- Use Firebase SDK more efficiently

**Issue: Data inconsistency**
- Run sync job regularly
- Implement conflict resolution
- Use transactions for critical updates

---

For more information, visit [Firebase Documentation](https://firebase.google.com/docs)

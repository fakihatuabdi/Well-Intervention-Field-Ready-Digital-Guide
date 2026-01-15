// Firebase Real-Time View Counter
// This file will be used when Firebase is configured

class FirebaseViewCounter {
  constructor() {
    // Check if Firebase is loaded
    if (typeof firebase !== 'undefined' && firebase.database) {
      this.database = firebase.database();
      this.isInitialized = true;
    } else {
      console.warn('Firebase not initialized. View counting will use fallback mode.');
      this.isInitialized = false;
    }
  }

  // Increment view count untuk artikel
  async incrementArticleView(articleId) {
    if (!this.isInitialized) {
      console.log('Firebase not available, using Rails backend for view count');
      return this.incrementViaRails(articleId);
    }

    const viewRef = this.database.ref(`article_views/${articleId}`);
    
    try {
      await viewRef.transaction((currentViews) => {
        return (currentViews || 0) + 1;
      });
      console.log(`Article ${articleId} view incremented via Firebase`);
    } catch (error) {
      console.error('Error incrementing view:', error);
      // Fallback to Rails
      this.incrementViaRails(articleId);
    }
  }

  // Fallback: increment via Rails AJAX
  incrementViaRails(articleId) {
    fetch(`/articles/${articleId}/increment_view`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log('View count updated via Rails:', data.view_count);
    })
    .catch(error => console.error('Error updating view count:', error));
  }

  // Listen untuk perubahan view count real-time
  watchArticleViews(articleId, callback) {
    if (!this.isInitialized) {
      return; // Skip if Firebase not available
    }

    const viewRef = this.database.ref(`article_views/${articleId}`);
    
    viewRef.on('value', (snapshot) => {
      const viewCount = snapshot.val() || 0;
      callback(viewCount);
    });
  }

  // Unsubscribe dari listener
  unwatchArticleViews(articleId) {
    if (!this.isInitialized) return;

    const viewRef = this.database.ref(`article_views/${articleId}`);
    viewRef.off();
  }

  // Get view count sekali (tidak real-time)
  async getArticleViews(articleId) {
    if (!this.isInitialized) return null;

    const viewRef = this.database.ref(`article_views/${articleId}`);
    const snapshot = await viewRef.once('value');
    return snapshot.val() || 0;
  }

  // Batch get multiple article views
  async getMultipleArticleViews(articleIds) {
    if (!this.isInitialized) return [];

    const promises = articleIds.map(id => this.getArticleViews(id));
    return await Promise.all(promises);
  }

  // Animate number change
  animateCount(element, targetCount) {
    const currentCount = parseInt(element.textContent) || 0;
    const increment = targetCount > currentCount ? 1 : -1;
    const duration = 500; // ms
    const steps = Math.abs(targetCount - currentCount);
    const stepDuration = Math.min(duration / steps, 50);

    let current = currentCount;
    const timer = setInterval(() => {
      current += increment;
      element.textContent = current;
      
      if ((increment > 0 && current >= targetCount) || 
          (increment < 0 && current <= targetCount)) {
        element.textContent = targetCount;
        clearInterval(timer);
      }
    }, stepDuration);
  }
}

// Initialize global instance
document.addEventListener('DOMContentLoaded', () => {
  window.firebaseViewCounter = new FirebaseViewCounter();
  console.log('Firebase View Counter initialized');
});

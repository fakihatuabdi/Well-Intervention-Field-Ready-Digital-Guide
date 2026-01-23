// Notification System - Consistent across all pages
class NotificationManager {
  constructor() {
    this.notifications = [];
  }

  show(type, message, duration = 3000) {
    const notification = this.createNotification(type, message);
    document.body.appendChild(notification);
    this.notifications.push(notification);
    
    // Trigger animation
    setTimeout(() => notification.classList.add('show'), 10);
    
    // Auto remove
    if (duration > 0) {
      setTimeout(() => this.remove(notification), duration);
    }
    
    return notification;
  }

  createNotification(type, message) {
    const notification = document.createElement('div');
    notification.className = 'notification-toast';
    
    const colors = {
      success: 'bg-green-100 border-green-500 text-green-700',
      error: 'bg-red-100 border-red-500 text-red-700',
      warning: 'bg-yellow-100 border-yellow-500 text-yellow-700',
      info: 'bg-blue-100 border-blue-500 text-blue-700'
    };
    
    const icons = {
      success: '<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>',
      error: '<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path></svg>',
      warning: '<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>',
      info: '<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>'
    };
    
    const colorClass = colors[type] || colors.info;
    const icon = icons[type] || icons.info;
    
    notification.innerHTML = `
      <div class="${colorClass} border-l-4 p-4 rounded shadow-lg">
        <div class="flex items-center">
          ${icon}
          <p class="font-medium">${message}</p>
        </div>
      </div>
    `;
    
    return notification;
  }

  remove(notification) {
    notification.classList.remove('show');
    notification.classList.add('hide');
    
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
      const index = this.notifications.indexOf(notification);
      if (index > -1) {
        this.notifications.splice(index, 1);
      }
    }, 300);
  }

  removeAll() {
    this.notifications.forEach(notification => this.remove(notification));
  }
}

// Initialize global notification manager
function initializeNotificationManager() {
  if (!window.notificationManager) {
    window.notificationManager = new NotificationManager();
  }
}

// Add styles
const style = document.createElement('style');
style.textContent = `
  .notification-toast {
    position: fixed;
    top: 1rem;
    right: 1rem;
    z-index: 9999;
    max-width: 28rem;
    opacity: 0;
    transform: translateX(100%);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  
  .notification-toast.show {
    opacity: 1;
    transform: translateX(0);
  }
  
  .notification-toast.hide {
    opacity: 0;
    transform: translateX(100%);
  }
`;
document.head.appendChild(style);

// Initialize immediately
initializeNotificationManager();

// Re-initialize on Turbo load
document.addEventListener('turbo:load', initializeNotificationManager);

// Cleanup before cache
document.addEventListener('turbo:before-cache', () => {
  if (window.notificationManager) {
    window.notificationManager.removeAll();
  }
});

export default NotificationManager;

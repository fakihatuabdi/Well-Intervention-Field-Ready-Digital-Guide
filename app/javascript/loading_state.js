// Loading State Manager
class LoadingStateManager {
  constructor() {
    this.loadingElements = new Map();
    this.setupStyles();
  }

  setupStyles() {
    if (!document.getElementById('loading-state-styles')) {
      const style = document.createElement('style');
      style.id = 'loading-state-styles';
      style.textContent = `
        .loading-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(255, 255, 255, 0.9);
          backdrop-filter: blur(4px);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 9999;
          opacity: 0;
          transition: opacity 0.3s ease;
        }
        
        .loading-overlay.active {
          opacity: 1;
        }
        
        .loading-spinner {
          width: 50px;
          height: 50px;
          border: 4px solid #e0f2fe;
          border-top-color: #0ea5e9;
          border-radius: 50%;
          animation: spin 0.8s linear infinite;
        }
        
        @keyframes spin {
          to { transform: rotate(360deg); }
        }
        
        .btn-loading {
          position: relative;
          pointer-events: none;
          opacity: 0.7;
        }
        
        .btn-loading::after {
          content: '';
          position: absolute;
          width: 16px;
          height: 16px;
          top: 50%;
          right: 10px;
          margin-top: -8px;
          border: 2px solid transparent;
          border-top-color: currentColor;
          border-radius: 50%;
          animation: spin 0.6s linear infinite;
        }
      `;
      document.head.appendChild(style);
    }
  }

  show(containerId = 'body') {
    const container = containerId === 'body' ? document.body : document.getElementById(containerId);
    if (!container) return;

    let overlay = this.loadingElements.get(containerId);
    if (!overlay) {
      overlay = document.createElement('div');
      overlay.className = 'loading-overlay';
      overlay.innerHTML = '<div class="loading-spinner"></div>';
      container.appendChild(overlay);
      this.loadingElements.set(containerId, overlay);
    }

    // Trigger reflow for animation
    overlay.offsetHeight;
    overlay.classList.add('active');
  }

  hide(containerId = 'body') {
    const overlay = this.loadingElements.get(containerId);
    if (overlay) {
      overlay.classList.remove('active');
      setTimeout(() => {
        if (overlay.parentNode) {
          overlay.parentNode.removeChild(overlay);
        }
        this.loadingElements.delete(containerId);
      }, 300);
    }
  }

  buttonLoading(button, isLoading = true) {
    if (isLoading) {
      button.classList.add('btn-loading');
      button.disabled = true;
    } else {
      button.classList.remove('btn-loading');
      button.disabled = false;
    }
  }
}

// Initialize global loading manager
document.addEventListener('DOMContentLoaded', () => {
  window.loadingManager = new LoadingStateManager();
  
  // Show loading on Turbo navigation
  document.addEventListener('turbo:before-fetch-request', () => {
    window.loadingManager.show();
  });
  
  document.addEventListener('turbo:render', () => {
    window.loadingManager.hide();
  });
  
  // Hide loading on errors
  document.addEventListener('turbo:frame-missing', () => {
    window.loadingManager.hide();
  });
});

export default LoadingStateManager;

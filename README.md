# Well Intervention Field-Ready Digital Guide 🛢️

> A comprehensive digital handbook for upstream oil & gas well intervention operations

[![Rails](https://img.shields.io/badge/Rails-7.1-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.3-red.svg)](https://www.ruby-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Documentation](#documentation)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

Well Intervention Field-Ready Digital Guide adalah aplikasi web untuk manajemen pengetahuan dan referensi operasi well intervention di industri minyak dan gas. Aplikasi ini menyediakan akses cepat ke handbook, artikel teknis, dan tools kalkulator untuk tim lapangan.

### Built With

- **Framework**: Ruby on Rails 7.1
- **Frontend**: Tailwind CSS, Hotwire (Turbo + Stimulus)
- **Database**: SQLite (development), PostgreSQL (production)
- **Authentication**: Devise
- **Real-time**: Firebase Realtime Database
- **Deployment**: Render.com ready

## ✨ Features

### Core Features
- 📚 **Digital Handbook** - General Knowledge & Zona Rokan sections
- 🔍 **Advanced Search** - Fast full-text search with pagination
- 📖 **Article Management** - Categorized technical articles
- 🔖 **Bookmarks** - Save and organize favorite articles
- 💬 **AI Chat Bot** - Interactive Q&A (coming soon with real AI)
- 🧮 **Calculators** - Well intervention calculations (coming soon)

### Security Features (v2.0)
- 🔒 **Environment Variables** - No hardcoded credentials
- 🛡️ **CSRF Protection** - Enhanced API security
- 🔐 **User Authentication** - Devise-powered (optional)
- 🗃️ **PostgreSQL** - Production-ready database

### Performance Features
- ⚡ **Pagination** - Fast page loads with Kaminari
- 🔄 **Race Condition Free** - Atomic database operations
- 📊 **Real-time View Counts** - Firebase integration
- 🎨 **Loading States** - Visual feedback

### UX Features
- 📱 **Responsive Design** - Mobile-first approach
- 🎯 **Smooth Animations** - Modern UI transitions
- 💬 **Flash Messages** - Auto-dismissing notifications
- 🌐 **Persistent Chat** - Database-backed messaging

## 🚀 Quick Start

### Prerequisites

- Ruby 3.3.0 or higher
- Rails 7.1.3 or higher
- SQLite3 (development)
- PostgreSQL (production)
- Node.js & npm (for asset compilation)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd codespaces-rails
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # Optional: Load sample data
   ```

5. **Start the server**
   ```bash
   rails server
   # or for live reload:
   bin/dev
   ```

6. **Visit the application**
   ```
   http://localhost:3000
   ```

### Environment Variables

Create a `.env` file in the root directory:

```bash
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_DATABASE_URL=https://your_project.firebasedatabase.app
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id

# Database (Production only)
DATABASE_URL=postgresql://username:password@localhost/dbname
```

## 📚 Documentation

Detailed documentation available in the `docs/` directory:

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Complete setup instructions
- **[SECURITY_IMPROVEMENTS.md](SECURITY_IMPROVEMENTS.md)** - Security enhancements details
- **[DEPLOYMENT_INSTRUCTIONS.md](DEPLOYMENT_INSTRUCTIONS.md)** - Production deployment guide
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes
- **[SUMMARY_PERBAIKAN.md](SUMMARY_PERBAIKAN.md)** - Improvement summary (Indonesian)

## 🔒 Security

Version 2.0 includes comprehensive security improvements:

- ✅ No exposed credentials (all in ENV)
- ✅ CSRF protection on all API endpoints
- ✅ User authentication with Devise
- ✅ PostgreSQL for production
- ✅ Secure session management
- ✅ Error handling without information leakage

For security issues, please see [SECURITY_IMPROVEMENTS.md](SECURITY_IMPROVEMENTS.md).

## 🏗️ Architecture

```
app/
├── controllers/      # Request handlers with error handling
├── models/          # Data models with validations
│   ├── article.rb       # Technical articles
│   ├── bookmark.rb      # User bookmarks
│   ├── chat_message.rb  # Persistent chat
│   └── user.rb          # Authentication
├── views/           # ERB templates
├── javascript/      # Stimulus controllers & modules
│   ├── firebase_analytics.js
│   └── loading_state.js
└── assets/          # Stylesheets and images

config/
├── routes.rb        # Application routes
├── database.yml     # Database configuration
└── environments/    # Environment-specific configs

db/
├── migrate/         # Database migrations
├── schema.rb        # Current database schema
└── seeds.rb         # Sample data
```

## 🧪 Testing

```bash
# Run all tests
rails test

# Run specific test
rails test test/models/article_test.rb

# System tests
rails test:system
```

## 📦 Dependencies

### Production
- `rails` (~> 7.1.3) - Web framework
- `puma` (~> 6) - Web server
- `devise` (~> 4.9) - Authentication
- `kaminari` - Pagination
- `tailwindcss-rails` - CSS framework
- `dotenv-rails` - Environment variables

### Development
- `debug` - Debugging tools
- `solargraph` - Ruby language server
- `hotwire-livereload` - Auto-reload

## 🚀 Deployment

### Render.com (Recommended)

1. Connect your repository
2. Set environment variables
3. Add PostgreSQL database
4. Deploy!

See [DEPLOYMENT_INSTRUCTIONS.md](DEPLOYMENT_INSTRUCTIONS.md) for detailed steps.

### Quick Deploy Commands

```bash
# Generate secret
rails secret

# Precompile assets
rails assets:precompile RAILS_ENV=production

# Run migrations
rails db:migrate RAILS_ENV=production
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📊 Project Status

- **Version**: 2.0.0
- **Status**: Production Ready ✅
- **Last Updated**: January 21, 2026

### Roadmap

- [x] Core handbook features
- [x] Search and bookmarks
- [x] User authentication
- [x] Security improvements
- [x] Error handling
- [ ] Real AI integration
- [ ] Calculator implementation
- [ ] Admin dashboard
- [ ] Mobile app API

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Development Team** - Initial work and v2.0 improvements

## 🙏 Acknowledgments

- Rails community for excellent documentation
- Tailwind CSS for the styling framework
- Firebase for real-time capabilities
- All contributors and testers

## 📞 Support

For issues, questions, or suggestions:

1. Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for common solutions
2. Review [SECURITY_IMPROVEMENTS.md](SECURITY_IMPROVEMENTS.md)
3. Create an issue in the repository
4. Contact the development team

---

**Made with ❤️ for the Oil & Gas Industry**

*Last updated: January 21, 2026*

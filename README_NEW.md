# Well Intervention Field-Ready Digital Guide

![Rails](https://img.shields.io/badge/Rails-7.1.3-red)
![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red)
![Tailwind](https://img.shields.io/badge/Tailwind-CSS-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 📖 Overview

**Well Intervention Field-Ready Digital Guide** adalah aplikasi web modern dan responsif yang dirancang khusus untuk industri upstream oil & gas. Aplikasi ini menyediakan panduan komprehensif untuk operasi well intervention yang dapat diakses melalui web browser (PC maupun smartphone) dan nantinya akan dikembangkan menjadi native mobile app.

### ✨ Key Features

- **🏠 Home Dashboard** - Homepage yang eye-catching dengan berbagai sections informatif
- **📚 Handbook** - Dokumentasi lengkap dengan dua kategori utama:
  - General Knowledge (11 artikel)
  - WK Rokan Operation (Multiple divisions termasuk Rig Hub)
- **🔍 Search** - Pencarian artikel yang powerful dengan full-text search
- **🧮 Calculator** - Tools kalkulasi untuk operasi well intervention (Coming Soon)
- **🤖 AI Chat Bot** - Asisten AI untuk menjawab pertanyaan seputar handbook (In Development)
- **🔖 Bookmarks** - Simpan dan track progress membaca artikel

### 🎨 Design Philosophy

- **Modern & Elegant** - UI/UX yang clean dan profesional
- **Smooth Animations** - Transisi dan animasi yang halus dan tidak mengganggu
- **Fully Responsive** - Optimal di semua ukuran layar (Mobile & Desktop)
- **User-Friendly** - Navigasi intuitif dan mudah digunakan

## 🚀 Getting Started

### Prerequisites

- Ruby 3.3.0 atau lebih tinggi
- Rails 7.1.3 atau lebih tinggi
- Node.js (untuk asset compilation)
- SQLite3

### Installation

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd codespaces-rails
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start development server**
   ```bash
   bin/dev
   ```
   
   Atau jika menggunakan rails server saja:
   ```bash
   rails server
   ```

5. **Access aplikasi**
   - Buka browser dan akses `http://localhost:3000`

## 📱 Application Structure

### Main Features

#### 1. Home
- **Case Studies / Lessons Learned** - Studi kasus operasional
- **Popular Articles** - Artikel paling banyak dibaca dengan real-time view counter
- **Updates & Notices** - Pengumuman dan update terbaru

#### 2. Handbook

##### General Knowledge
Berisi 11 artikel fundamental:
- Abbreviation
- Drilling & Well Intervention Safety
- HSSE Rig Operation
- Rig Unit
- Pre-Well Intervention Execution
- Well Intervention Operation
- Well Problem Handling
- Packer
- Well Head
- Well Completion
- Artificial Lift
- Glossary

##### WK Rokan Operation
- **Rig Hub** - 10 artikel operasional termasuk:
  - Objective
  - Rig Hub Introduction
  - On-Boarding Process
  - Sumatera Operation Area
  - Artificial Lift
  - Heavy Oil Best Practice
  - Light Oil Best Practice
  - Special Operation
  - Simultaneous Operations (SIMOPS)
  - Appendix
- **Other Divisions** - Coming Soon

#### 3. Search
- Full-text search across semua artikel
- Filter berdasarkan kategori dan subcategory
- Pagination untuk hasil yang banyak

#### 4. Calculator (Coming Soon)
- Initial Killing & Pumping
- Pump Stuck Suspension
- Other Operation Calculations
- Dan calculator lainnya yang sedang dikembangkan

#### 5. AI Chat Bot (In Development)
- Menjawab pertanyaan seputar well intervention
- Belajar dari konten handbook
- Context-aware responses

#### 6. Bookmarks
- Simpan artikel favorit
- Track reading progress
- Quick access ke artikel yang disimpan

## 🛠️ Technology Stack

### Backend
- **Ruby on Rails 7.1.3** - Web framework
- **SQLite3** - Database (development)
- **PgSearch** - Full-text search functionality

### Frontend
- **Tailwind CSS** - Styling framework
- **Stimulus.js** - JavaScript framework
- **Turbo** - SPA-like experience
- **Custom CSS Animations** - Smooth transitions

### Additional Tools
- **Kaminari** - Pagination
- **Firebase** (Planned) - Real-time view counter

## 📊 Database Models

### Article
```ruby
- title: string
- category: string (general_knowledge, wk_rokan)
- subcategory: string (rig_hub, etc.)
- content: text
- slug: string (unique)
- published: boolean
- view_count: integer
```

### Bookmark
```ruby
- article_id: integer
- user_id: integer (future feature)
- last_position: text
```

### CaseStudy
```ruby
- title: string
- description: text
- content: text
- published: boolean
```

### Update
```ruby
- title: string
- content: text
- published_at: datetime
- category: string
```

## 🎯 Roadmap

### Phase 1 (Current) ✅
- [x] Basic application structure
- [x] Responsive layout with navigation
- [x] Handbook with articles
- [x] Search functionality
- [x] Bookmarks feature
- [x] Home dashboard

### Phase 2 (Next)
- [ ] Firebase integration untuk real-time view counter
- [ ] Calculator tools implementation
- [ ] User authentication & authorization
- [ ] Advanced AI Chat Bot dengan machine learning
- [ ] Enhanced article editor dengan rich text
- [ ] Export/PDF functionality

### Phase 3 (Future)
- [ ] Native mobile app (iOS & Android)
- [ ] Offline mode
- [ ] Multi-language support
- [ ] Advanced analytics dashboard
- [ ] Team collaboration features
- [ ] Version control untuk articles

## 🎨 UI/UX Features

### Animations
- **Fade In** - Smooth entrance animations
- **Slide In** - Sliding elements
- **Hover Lift** - Interactive card hover effects
- **Glass Effect** - Modern glassmorphism design

### Responsive Design
- Mobile-first approach
- Breakpoints untuk berbagai ukuran layar
- Touch-friendly interface
- Optimized performance

## 🔐 Security Considerations

- CSRF protection enabled
- Input sanitization
- Secure session handling
- SQL injection prevention (ActiveRecord)

## 📝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team

Developed for Upstream Oil & Gas Operations

## 🤝 Support

Untuk pertanyaan, issues, atau feedback, silakan buka issue di GitHub repository.

---

**Built with ❤️ for the Oil & Gas Industry**

*Version 1.0 - January 2026*

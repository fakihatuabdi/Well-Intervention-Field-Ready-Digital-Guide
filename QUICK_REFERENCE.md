# 🎯 Quick Reference Card

## Essential Commands

### Development
```bash
# Start server
rails server              # or: rails s
bin/dev                  # with live reload

# Console
rails console            # or: rails c

# Database
rails db:migrate         # Run migrations
rails db:seed           # Load sample data
rails db:reset          # Reset database (destructive!)

# Routes
rails routes | grep articles    # Find routes
```

### Testing
```bash
# Run tests
rails test
rails test test/models/article_test.rb

# Check for errors
rails runner "puts Article.count"
```

### Assets
```bash
# Precompile
rails assets:precompile

# Clean
rails assets:clobber
```

---

## Important Files

| File | Purpose |
|------|---------|
| `.env` | Local environment variables (not committed) |
| `config/database.yml` | Database configuration |
| `config/routes.rb` | URL routing |
| `db/schema.rb` | Current database structure |
| `Gemfile` | Ruby dependencies |

---

## Models Quick Reference

```ruby
# User
User.create!(email: 'user@example.com', password: 'password')
User.count

# Article
Article.published                    # Published articles
Article.popular                      # Top 5 by views
Article.search_by_all('keyword')    # Search

# Bookmark
Bookmark.includes(:article)         # With article data

# ChatMessage
ChatMessage.for_user(user)          # User's messages
ChatMessage.for_session(session_id) # Anonymous messages
```

---

## Controllers Quick Reference

### Error Handling Pattern
```ruby
def action
  # ... your code
rescue ActiveRecord::RecordNotFound
  redirect_to root_path, alert: "Not found"
rescue => e
  Rails.logger.error "Error: #{e.message}"
  flash.now[:alert] = "An error occurred"
end
```

### Pagination Pattern
```ruby
@articles = Article.published
                  .page(params[:page])
                  .per(12)
```

---

## Environment Variables

### Required for Development
```bash
FIREBASE_API_KEY=your_key
FIREBASE_AUTH_DOMAIN=your_domain
FIREBASE_DATABASE_URL=your_url
FIREBASE_PROJECT_ID=your_project
FIREBASE_STORAGE_BUCKET=your_bucket
FIREBASE_MESSAGING_SENDER_ID=your_id
FIREBASE_APP_ID=your_app_id
```

### Required for Production
```bash
# All above, plus:
SECRET_KEY_BASE=<rails secret>
RAILS_MASTER_KEY=<from config/master.key>
DATABASE_URL=postgresql://user:pass@host/db
```

---

## Routes

```ruby
# Main routes
GET  /                              # home#index
GET  /handbook                      # handbook#index
GET  /handbook/general_knowledge    # handbook#general_knowledge
GET  /handbook/wk_rokan            # handbook#wk_rokan
GET  /handbook/rig_hub             # handbook#rig_hub
GET  /search                        # search#index
GET  /calculator                    # calculator#index
GET  /chat_bot                      # chat_bot#index
POST /chat_bot/send_message        # chat_bot#send_message
GET  /bookmarks                     # bookmarks#index
GET  /articles/:id                  # articles#show
POST /articles/:id/increment_view  # articles#increment_view
POST /articles/:id/bookmark        # articles#bookmark

# Devise (if using authentication)
GET  /users/sign_in                # Sign in
GET  /users/sign_up                # Sign up
DELETE /users/sign_out             # Sign out
```

---

## Common Tasks

### Create New Article
```ruby
Article.create!(
  title: "New Article",
  category: "general_knowledge",
  subcategory: nil,
  content: "Article content here...",
  published: true
)
```

### Add Migration
```bash
rails generate migration AddFieldToModel field:type
rails db:migrate
```

### Check Logs
```bash
tail -f log/development.log
tail -f log/production.log
```

### Clear Cache
```bash
rails dev:cache        # Toggle caching in development
rails tmp:clear        # Clear tmp files
```

---

## Troubleshooting

### Server Won't Start
```bash
# Check for running processes
lsof -i :3000

# Kill if needed
kill -9 $(lsof -t -i:3000)

# Remove PID file
rm tmp/pids/server.pid
```

### Database Issues
```bash
# Reset development database
rails db:drop db:create db:migrate db:seed

# Check migrations
rails db:migrate:status

# Rollback last migration
rails db:rollback
```

### Asset Issues
```bash
# Recompile assets
rails assets:precompile

# Clear asset cache
rails tmp:cache:clear
```

### Firebase Not Working
1. Check `.env` file exists
2. Verify ENV vars in console: `ENV['FIREBASE_API_KEY']`
3. Check browser console for JavaScript errors
4. Test: `firebase.apps.length > 0`

---

## Security Checklist

- [ ] `.env` in `.gitignore`
- [ ] No hardcoded credentials
- [ ] CSRF tokens in AJAX calls
- [ ] Error messages don't leak info
- [ ] Input validation on all forms
- [ ] SSL enabled in production
- [ ] Database backups configured

---

## Performance Tips

1. **Use pagination** - Don't load all records
2. **Add indexes** - On frequently queried columns
3. **Use includes** - Avoid N+1 queries
4. **Cache queries** - For expensive operations
5. **Optimize images** - Compress before upload

---

## Useful Links

- **Documentation**: See `*.md` files in root
- **Rails Guides**: https://guides.rubyonrails.org/
- **Devise**: https://github.com/heartcombo/devise
- **Tailwind CSS**: https://tailwindcss.com/docs
- **Firebase**: https://firebase.google.com/docs

---

## Git Workflow

```bash
# Check status
git status

# Add changes
git add .

# Commit
git commit -m "Description of changes"

# Push
git push origin main

# Pull latest
git pull origin main

# Create branch
git checkout -b feature/new-feature
```

---

## Production Deployment

1. Set environment variables
2. Add PostgreSQL database
3. Run migrations: `rails db:migrate`
4. Precompile assets: `rails assets:precompile`
5. Start server: `bundle exec puma -C config/puma.rb`

See [DEPLOYMENT_INSTRUCTIONS.md](DEPLOYMENT_INSTRUCTIONS.md) for details.

---

## Contact & Support

- **Issues**: Check SETUP_GUIDE.md first
- **Security**: See SECURITY_IMPROVEMENTS.md
- **Changes**: Check CHANGELOG.md

---

**Version**: 2.0.0  
**Last Updated**: January 21, 2026

💡 **Pro Tip**: Bookmark this file for quick reference!

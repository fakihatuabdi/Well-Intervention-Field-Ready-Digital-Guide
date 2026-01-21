# 🚀 Deployment Instructions

## Platform: Render.com (Recommended)

### Prerequisites
- Git repository (GitHub, GitLab, or Bitbucket)
- Render account (free tier available)
- PostgreSQL database (provided by Render)

---

## Step-by-Step Deployment

### 1. Prepare Your Repository

Ensure these files are committed:
```bash
git add .
git commit -m "Ready for production deployment - v2.0"
git push origin main
```

### 2. Create New Web Service on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your Git repository
4. Configure:

```yaml
Name: well-intervention-guide
Environment: Ruby
Build Command: ./bin/render-build.sh
Start Command: bundle exec puma -C config/puma.rb
```

### 3. Add Environment Variables

In Render dashboard, go to **Environment** tab and add:

#### Required:
```bash
RAILS_ENV=production
RAILS_MASTER_KEY=[your_master_key_from_config/master.key]
SECRET_KEY_BASE=[generate_with_rails_secret]

# Database (automatically provided by Render if you add PostgreSQL)
DATABASE_URL=[auto-filled by Render]

# Firebase Configuration
FIREBASE_API_KEY=AIzaSyB2Kx60bD58HQ5JqwbqjYaALzEhHQIPbkw
FIREBASE_AUTH_DOMAIN=wi-field-ready-digital-guide.firebaseapp.com
FIREBASE_DATABASE_URL=https://wi-field-ready-digital-guide-default-rtdb.asia-southeast1.firebasedatabase.app
FIREBASE_PROJECT_ID=wi-field-ready-digital-guide
FIREBASE_STORAGE_BUCKET=wi-field-ready-digital-guide.firebasestorage.app
FIREBASE_MESSAGING_SENDER_ID=51623643193
FIREBASE_APP_ID=1:51623643193:web:6f244103625708e57a25e8

# Rails Configuration
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true
```

#### Generate SECRET_KEY_BASE:
```bash
rails secret
# Copy output and use as SECRET_KEY_BASE
```

### 4. Add PostgreSQL Database

1. In Render dashboard, click **"New +"** → **"PostgreSQL"**
2. Name: `well-intervention-db`
3. Database: `well_intervention_production`
4. User: (auto-generated)
5. Plan: Free tier or Starter ($7/month)
6. Create Database

7. Link database to web service:
   - Go to your web service
   - Environment tab
   - DATABASE_URL will be auto-filled

### 5. Configure Action Mailer (Optional but Recommended)

Add to environment variables:
```bash
MAILER_HOST=your-app-name.onrender.com
MAILER_FROM=noreply@your-domain.com

# If using SendGrid, Mailgun, etc:
SMTP_ADDRESS=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USERNAME=apikey
SMTP_PASSWORD=your_api_key
```

### 6. Deploy!

1. Click **"Create Web Service"**
2. Render will:
   - Clone your repository
   - Run `bin/render-build.sh`
   - Install dependencies
   - Run migrations
   - Start server

3. Monitor deployment in **Logs** tab

### 7. Post-Deployment

#### Verify deployment:
```bash
# Check if site is live
curl https://your-app-name.onrender.com

# Should return HTML content
```

#### Run seeds (if needed):
```bash
# In Render Shell:
rails db:seed
```

#### Access Render Shell:
1. Go to your service
2. Click **"Shell"** tab
3. Run commands:
```bash
rails console
rails db:migrate:status
rails routes | grep articles
```

---

## Alternative: Heroku Deployment

### Quick Deploy to Heroku

```bash
# Install Heroku CLI
brew install heroku/brew/heroku

# Login
heroku login

# Create app
heroku create well-intervention-guide

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Set environment variables
heroku config:set RAILS_ENV=production
heroku config:set SECRET_KEY_BASE=$(rails secret)
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)
heroku config:set FIREBASE_API_KEY=your_key
# ... add all other ENV vars

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate

# Seed database
heroku run rails db:seed

# Open app
heroku open
```

---

## Deployment Checklist

### Before Deployment:
- [x] All tests passing
- [x] Environment variables documented
- [x] Database migrations ready
- [x] Assets precompiled
- [x] `.env` in `.gitignore`
- [x] Master key secured
- [x] Error handling implemented
- [x] Security headers configured

### During Deployment:
- [ ] Environment variables set on platform
- [ ] Database created and linked
- [ ] Build script runs successfully
- [ ] Migrations executed
- [ ] Assets compiled and served
- [ ] Health check endpoint working

### After Deployment:
- [ ] Test all major features
- [ ] Check error logs
- [ ] Verify Firebase connection
- [ ] Test authentication flows
- [ ] Monitor performance
- [ ] Setup monitoring (optional)

---

## Monitoring & Maintenance

### Check Application Health

Render provides:
- **Health Check**: `/up` endpoint (auto-configured)
- **Logs**: Real-time log streaming
- **Metrics**: CPU, Memory usage
- **Deploy Notifications**: Email/Slack

### View Logs

```bash
# In Render Dashboard
Logs tab → Live tail

# Or via CLI (if using Heroku)
heroku logs --tail
```

### Database Backups

Render PostgreSQL includes:
- Automatic daily backups (retained 7 days)
- Manual backup option
- Point-in-time recovery

To backup manually:
```bash
# Render CLI
render db backup create well-intervention-db
```

### Scaling

Free tier limitations:
- 512 MB RAM
- Sleeps after 15 min inactivity
- Slow wake-up time

To upgrade:
1. Go to service settings
2. Choose Starter plan ($7/month)
3. Benefits:
   - No sleep
   - 512 MB RAM
   - Custom domains
   - SSL included

---

## Troubleshooting

### Common Issues

#### 1. Build Fails
```bash
# Check bin/render-build.sh is executable
chmod +x bin/render-build.sh

# Check Gemfile.lock includes correct platform
bundle lock --add-platform x86_64-linux
git add Gemfile.lock
git commit -m "Add Linux platform"
git push
```

#### 2. Database Connection Error
```bash
# Verify DATABASE_URL is set
render shell
echo $DATABASE_URL

# Test connection
rails dbconsole
```

#### 3. Assets Not Loading
```bash
# Check RAILS_SERVE_STATIC_FILES is set
heroku config:get RAILS_SERVE_STATIC_FILES

# Verify assets compiled
rails assets:precompile
```

#### 4. Secret Key Error
```bash
# Generate new key
rails secret

# Set in environment
render config:set SECRET_KEY_BASE=your_new_key
```

#### 5. Firebase Not Working
```bash
# Check ENV vars
render config | grep FIREBASE

# Test in console
rails console
ENV['FIREBASE_API_KEY']
```

### Get Help

- Render Docs: https://render.com/docs
- Rails Guides: https://guides.rubyonrails.org/
- Project Issues: Create issue in repository

---

## Performance Optimization

### Recommended Settings

In `config/environments/production.rb`:

```ruby
# Enable caching
config.cache_classes = true
config.action_controller.perform_caching = true

# Compress assets
config.assets.compress = true
config.assets.compile = false

# Use CDN (optional)
# config.asset_host = 'https://cdn.example.com'

# Enable SSL
config.force_ssl = true
```

### Database Optimization

```ruby
# config/database.yml
production:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  prepared_statements: true
  advisory_locks: true
```

---

## Security Best Practices

1. **Never commit secrets**
   - Use environment variables
   - Keep `.env` in `.gitignore`
   - Rotate credentials regularly

2. **Enable SSL**
   ```ruby
   config.force_ssl = true
   ```

3. **Setup rate limiting** (future enhancement)
   ```ruby
   gem 'rack-attack'
   ```

4. **Monitor errors**
   - Consider Sentry, Rollbar, or Honeybadger
   - Setup alerting

5. **Regular updates**
   ```bash
   bundle update
   rails app:update
   ```

---

## Cost Estimation

### Render (Recommended)

**Free Tier:**
- Web Service: Free (with limitations)
- PostgreSQL: $7/month (Starter) or Free (limited)
- **Total: $0-7/month**

**Starter Tier:**
- Web Service: $7/month
- PostgreSQL: $7/month
- **Total: $14/month**

### Heroku

**Eco Dynos:**
- Web Dyno: $5/month
- PostgreSQL: $9/month (Mini)
- **Total: $14/month**

---

## Next Steps After Deployment

1. **Setup Custom Domain**
   - Add DNS records
   - Configure SSL

2. **Enable Monitoring**
   - Setup error tracking
   - Add analytics

3. **Configure Backups**
   - Schedule regular backups
   - Test restoration

4. **Load Testing**
   - Test with expected traffic
   - Optimize bottlenecks

5. **Documentation**
   - Update README with production URL
   - Document any custom configurations

---

**Deployment Date:** _______________  
**Deployed By:** _______________  
**Production URL:** _______________  

**Status:** ⬜ Deployed ⬜ Tested ⬜ Live

---

_For questions or issues, refer to SETUP_GUIDE.md or create an issue in the repository._

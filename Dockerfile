# Dockerfile for Rails application on Fly.io
FROM ruby:3.3.6-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs sqlite3 libsqlite3-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# Copy application code
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Create database directory and set permissions
RUN mkdir -p /app/storage /app/db && \
    chmod 755 /app/storage /app/db

# Expose port
EXPOSE 8080

# Start the server
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]

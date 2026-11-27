# syntax=docker/dockerfile:1
# Production image. Used by docker-compose.yml (local / intranet server, see
# docs/audit-it/02-INSTALASI.md) and by Northflank (docs/DEPLOY_NORTHFLANK.md).

ARG RUBY_VERSION=3.3.14
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES=1 \
    RAILS_LOG_TO_STDOUT=1 \
    WEB_CONCURRENCY=0 \
    RAILS_MAX_THREADS=5 \
    PORT=3000

# Runtime packages only: PostgreSQL client library
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libpq5 && \
    rm -rf /var/lib/apt/lists/*

# ---------- build stage ----------
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

# Scripts must have Unix line endings and be executable, even when the code
# was downloaded on Windows.
RUN sed -i 's/\r$//' bin/* && chmod +x bin/*

RUN bundle exec bootsnap precompile app/ lib/ && \
    SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ---------- final stage ----------
FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp/pids && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s \
  CMD curl -fs http://localhost:${PORT}/up || exit 1
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

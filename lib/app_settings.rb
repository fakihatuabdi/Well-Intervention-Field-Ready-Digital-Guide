# Settings an administrator can change with environment variables, without
# touching the code. Every setting has a safe default, so the app works (and
# is locked down) even when nothing is set. See docs/audit-it/03-KONFIGURASI.md.
module AppSettings
  TRUE_VALUES = %w[1 true yes y on ya].freeze

  module_function

  def flag(name, default)
    value = ENV[name]
    return default if value.nil? || value.strip.empty?

    TRUE_VALUES.include?(value.strip.downcase)
  end

  # Visitors must sign in before they can read anything (default: yes).
  def require_login?
    flag("REQUIRE_LOGIN", true)
  end

  # Anyone with an allowed email domain may request an account. New accounts
  # stay "pending" until an admin approves them (default: off; admins create
  # accounts).
  def allow_signup?
    flag("ALLOW_SIGNUP", false)
  end

  # Comma separated list, e.g. "company.co.id,company.com". Empty = any domain
  # (only relevant when ALLOW_SIGNUP is on).
  def signup_email_domains
    ENV.fetch("SIGNUP_EMAIL_DOMAIN", "").split(",").map { |d| d.strip.downcase.delete_prefix("@") }.reject(&:empty?)
  end

  # The chat bot page. Off by default: when an AI service is added later it
  # would send questions outside the company network.
  def chat_bot_enabled?
    flag("CHAT_BOT_ENABLED", false)
  end

  # Signed-in users are signed out after this many minutes without activity.
  def session_timeout
    minutes = Integer(ENV.fetch("SESSION_TIMEOUT_MINUTES", "480"), exception: false)
    (minutes && minutes.positive? ? minutes : 480).minutes
  end

  # Only turn on when the app is served over HTTPS (e.g. behind a proxy).
  def force_ssl?
    flag("FORCE_SSL", false)
  end
end

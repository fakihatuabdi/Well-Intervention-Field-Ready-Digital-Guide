class User < ApplicationRecord
  ROLES = %w[admin pengguna].freeze
  STATUSES = %w[pending active disabled].freeze
  ROLE_LABELS = { "admin" => "Admin", "pengguna" => "Pengguna (read only)" }.freeze
  STATUS_LABELS = { "pending" => "Waiting for approval", "active" => "Active", "disabled" => "Disabled" }.freeze

  # No :recoverable (password reset e-mails): the app runs without a mail
  # server, so an admin resets passwords. :lockable locks an account after
  # repeated wrong passwords; :timeoutable signs idle users out.
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  has_many :bookmarks, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :bookmarked_articles, through: :bookmarks, source: :article

  # Set by the sign-up form so the e-mail domain rule applies only to people
  # registering themselves, not to accounts an admin creates.
  attr_accessor :self_signup

  validates :role, inclusion: { in: ROLES }
  validates :status, inclusion: { in: STATUSES }
  validates :name, length: { maximum: 100 }
  validate :password_complexity
  validate :email_domain_allowed, if: :self_signup

  before_validation :normalize_fields

  scope :admins, -> { where(role: "admin") }
  scope :active, -> { where(status: "active") }
  scope :pending, -> { where(status: "pending") }

  def admin?
    role == "admin"
  end

  def active?
    status == "active"
  end

  def pending?
    status == "pending"
  end

  def display_name
    name.presence || email
  end

  def role_label
    ROLE_LABELS.fetch(role, role)
  end

  def status_label
    STATUS_LABELS.fetch(status, status)
  end

  # Devise: only active accounts may sign in.
  def active_for_authentication?
    super && active?
  end

  def inactive_message
    return super if active?

    pending? ? :not_approved : :account_disabled
  end

  def timeout_in
    AppSettings.session_timeout
  end

  # True when removing admin rights from (or disabling) this user would leave
  # the app without any active admin.
  def last_active_admin?
    admin? && active? && User.admins.active.where.not(id: id).none?
  end

  private

  def normalize_fields
    self.email = email.to_s.strip.downcase
    self.name = name.to_s.strip.presence
  end

  # At least one letter and one digit, on top of Devise's length rule.
  def password_complexity
    return if password.blank?
    return if password.match?(/[A-Za-z]/) && password.match?(/\d/)

    errors.add(:password, "must contain at least one letter and one number")
  end

  def email_domain_allowed
    domains = AppSettings.signup_email_domains
    return if domains.empty?

    domain = email.to_s.split("@").last.to_s.downcase
    return if domains.include?(domain)

    errors.add(:email, "must be a company address (#{domains.map { |d| "@#{d}" }.join(', ')})")
  end
end

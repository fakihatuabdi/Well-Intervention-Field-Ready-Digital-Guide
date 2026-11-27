# Account tasks for IT / the server operator (no mail server needed).
#
#   bin/rails users:create_admin EMAIL=admin@example.com PASSWORD='S3cret-pass'
#   bin/rails users:make_admin EMAIL=someone@example.com
#   bin/rails users:reset_password EMAIL=someone@example.com PASSWORD='N3w-pass'
#   bin/rails users:list
#
# With Docker:  docker compose exec app bin/rails users:list
namespace :users do
  def required_env(name)
    value = ENV[name].to_s.strip
    abort "Missing #{name}=... (see lib/tasks/users.rake)" if value.empty?
    value
  end

  desc "Create an active admin account (EMAIL, PASSWORD)"
  task create_admin: :environment do
    email = required_env("EMAIL").downcase
    password = required_env("PASSWORD")
    user = User.new(email: email, name: ENV["NAME"].presence || "Administrator", role: "admin",
                    status: "active", password: password, password_confirmation: password)
    if user.save
      AuditEvent.record!("user.create", target: user, details: { role: "admin", source: "rake" })
      puts "Admin created: #{email}"
    else
      abort "Not created: #{user.errors.full_messages.join(', ')}"
    end
  end

  desc "Give an existing account the admin role and activate it (EMAIL)"
  task make_admin: :environment do
    user = User.find_by(email: required_env("EMAIL").downcase) or abort "No account with that e-mail"
    user.update!(role: "admin", status: "active")
    AuditEvent.record!("user.update", target: user, details: { role: "admin", status: "active", source: "rake" })
    puts "#{user.email} is now an active admin."
  end

  desc "Set a new password and unlock the account (EMAIL, PASSWORD)"
  task reset_password: :environment do
    user = User.find_by(email: required_env("EMAIL").downcase) or abort "No account with that e-mail"
    password = required_env("PASSWORD")
    if user.update(password: password, password_confirmation: password)
      user.unlock_access! if user.access_locked?
      AuditEvent.record!("user.update", target: user, details: { password: "reset", source: "rake" })
      puts "Password changed for #{user.email}."
    else
      abort "Not changed: #{user.errors.full_messages.join(', ')}"
    end
  end

  desc "List all accounts"
  task list: :environment do
    User.order(:email).each do |u|
      puts format("%-40s %-9s %-9s last sign-in: %s", u.email, u.role, u.status, u.last_sign_in_at || "never")
    end
  end
end

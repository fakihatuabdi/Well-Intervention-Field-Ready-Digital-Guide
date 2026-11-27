# Record failed sign-in attempts in the audit log (e-mail tried + IP), so IT
# can spot password guessing. Passwords are never stored.
Warden::Manager.before_failure do |env, opts|
  next unless opts[:scope] == :user && opts[:action] == "unauthenticated"

  request = ActionDispatch::Request.new(env)
  email = request.params.dig("user", "email").to_s.strip.downcase.first(255)
  next if email.empty? # just visiting a page while signed out

  AuditEvent.record!("user.sign_in_failed", details: { email: email, reason: opts[:message] }.to_json, ip: request.remote_ip)
end

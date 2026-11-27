module Users
  # Adds sign-in / sign-out entries to the audit log.
  class SessionsController < Devise::SessionsController
    def create
      super do |user|
        AuditEvent.record!("user.sign_in", user: user, target: user, ip: request.remote_ip)
      end
    end

    def destroy
      user = current_user
      AuditEvent.record!("user.sign_out", user: user, target: user, ip: request.remote_ip) if user
      super
    end
  end
end

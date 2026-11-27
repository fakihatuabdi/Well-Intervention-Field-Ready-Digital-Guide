module Admin
  # Every admin page requires a signed-in, active user with the "admin" role,
  # even when REQUIRE_LOGIN=false.
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    layout "application"

    private

    def require_admin
      return if current_user&.admin?

      redirect_to root_path, alert: "Only administrators can open that page."
    end

    # Short "field: old -> new" summary for the audit log. Long text (article
    # bodies) is reported as "changed" only.
    def change_summary(record)
      record.saved_changes.except("updated_at", "created_at", "encrypted_password", "seed_digest").to_h do |field, (before, after)|
        if before.to_s.length > 120 || after.to_s.length > 120
          [field, "changed"]
        else
          [field, [before, after]]
        end
      end
    end
  end
end

module Users
  # Self sign-up is off unless ALLOW_SIGNUP=true. New accounts are always
  # "pengguna" (read only) and wait for an admin to approve them.
  # Signed-in users can still use the "edit account" page to change their
  # own password.
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_signup_allowed, only: %i[new create]
    # Accounts are removed by admins only (they are disabled, keeping history).
    before_action :block_self_delete, only: :destroy

    protected

    def build_resource(hash = {})
      super
      resource.role = "pengguna"
      resource.status = "pending"
      resource.self_signup = true
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:name, :password, :password_confirmation, :current_password)
    end

    def after_inactive_sign_up_path_for(_resource)
      new_user_session_path
    end

    def after_update_path_for(_resource)
      edit_user_registration_path
    end

    private

    def ensure_signup_allowed
      return if AppSettings.allow_signup?

      redirect_to new_user_session_path, alert: "Self sign-up is turned off. Please ask an administrator for an account."
    end

    def block_self_delete
      redirect_to edit_user_registration_path, alert: "Please ask an administrator to remove your account."
    end
  end
end

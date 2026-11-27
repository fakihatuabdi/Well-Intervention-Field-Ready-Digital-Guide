class ApplicationController < ActionController::Base
  helper_method :bookmark_owner, :chat_bot_enabled?

  before_action :require_login, unless: :devise_controller?

  private

  # Every page needs a signed-in user unless REQUIRE_LOGIN=false.
  def require_login
    authenticate_user! if AppSettings.require_login?
  end

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end

  def chat_bot_enabled?
    AppSettings.chat_bot_enabled?
  end

  # Bookmarks belong to the signed-in user, or to this browser's session for
  # visitors who are not signed in (only possible when REQUIRE_LOGIN=false).
  def bookmark_owner
    if current_user
      { user_id: current_user.id, session_id: nil }
    else
      session[:bookmark_session_id] ||= SecureRandom.uuid
      { user_id: nil, session_id: session[:bookmark_session_id] }
    end
  end

  def owned_bookmarks
    Bookmark.where(bookmark_owner)
  end

  def audit!(action, target: nil, details: nil)
    AuditEvent.record!(action, user: current_user, target: target, details: details, ip: request.remote_ip)
  end
end

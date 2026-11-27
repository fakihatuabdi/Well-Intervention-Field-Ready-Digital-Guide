class ApplicationController < ActionController::Base
  helper_method :bookmark_owner

  private

  # Bookmarks belong to the signed-in user, or to this browser's session for
  # visitors who are not signed in. Before this, every anonymous visitor
  # shared (and could delete) the same bookmark list.
  def bookmark_owner
    if respond_to?(:current_user, true) && current_user
      { user_id: current_user.id, session_id: nil }
    else
      session[:bookmark_session_id] ||= SecureRandom.uuid
      { user_id: nil, session_id: session[:bookmark_session_id] }
    end
  end

  def owned_bookmarks
    Bookmark.where(bookmark_owner)
  end
end

class BookmarksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :bookmark_not_found
  
  def index
    @bookmarks = Bookmark.includes(:article)
                        .order(updated_at: :desc)
                        .page(params[:page])
                        .per(12)
  rescue => e
    Rails.logger.error "Error loading bookmarks: #{e.message}"
    flash.now[:alert] = "An error occurred loading bookmarks."
    @bookmarks = Bookmark.none.page(params[:page])
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmarks_path, notice: 'Bookmark removed successfully'
  rescue => e
    Rails.logger.error "Error destroying bookmark: #{e.message}"
    redirect_to bookmarks_path, alert: 'Failed to remove bookmark'
  end
  
  private
  
  def bookmark_not_found
    redirect_to bookmarks_path, alert: 'Bookmark not found'
  end
end

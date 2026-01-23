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
    
    respond_to do |format|
      if bookmark.destroy
        format.html { redirect_to bookmarks_path, notice: 'Bookmark removed successfully' }
        format.json { render json: { success: true, message: 'Bookmark removed successfully' }, status: :ok }
      else
        format.html { redirect_to bookmarks_path, alert: 'Failed to remove bookmark' }
        format.json { render json: { success: false, message: 'Failed to remove bookmark' }, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Bookmark not found: #{e.message}"
    respond_to do |format|
      format.html { redirect_to bookmarks_path, alert: 'Bookmark not found' }
      format.json { render json: { success: false, message: 'Bookmark not found' }, status: :not_found }
    end
  rescue => e
    Rails.logger.error "Error destroying bookmark: #{e.message}"
    respond_to do |format|
      format.html { redirect_to bookmarks_path, alert: 'Failed to remove bookmark' }
      format.json { render json: { success: false, message: 'Failed to remove bookmark' }, status: :internal_server_error }
    end
  end
  
  private
  
  def bookmark_not_found
    redirect_to bookmarks_path, alert: 'Bookmark not found'
  end
end

class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.includes(:article).order(updated_at: :desc)
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmarks_path, notice: 'Bookmark removed successfully'
  end
end

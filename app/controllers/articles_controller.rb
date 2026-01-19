class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :increment_view, :bookmark]

  def show
    # Don't increment here - let JavaScript handle it for better control
    # This prevents double counting when page is refreshed
  end

  def increment_view
    @article.increment_view_count
    render json: { view_count: @article.view_count }
  end

  def bookmark
    bookmark = Bookmark.find_or_initialize_by(article_id: @article.id)
    bookmark.last_position = params[:position]
    
    if bookmark.save
      render json: { success: true, message: 'Bookmarked!' }
    else
      render json: { success: false, message: 'Failed to bookmark' }, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end

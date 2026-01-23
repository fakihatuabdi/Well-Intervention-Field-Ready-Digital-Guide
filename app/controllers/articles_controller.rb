class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :increment_view, :bookmark, :unbookmark, :sync_firebase, :check_bookmark]
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

  def index
    @articles = Article.where(published: true)
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { 
        render json: @articles.map { |a| { id: a.id, title: a.title, view_count: a.view_count || 0 } }
      }
    end
  rescue => e
    Rails.logger.error "Error loading articles: #{e.message}"
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Error loading articles" }
      format.json { render json: { error: 'Failed to load articles' }, status: :unprocessable_entity }
    end
  end

  def show
    @article.increment_view_count!
  rescue => e
    Rails.logger.error "Error showing article: #{e.message}"
    flash[:alert] = "An error occurred loading the article."
    redirect_to root_path
  end

  def increment_view
    @article.increment_view_count!
    render json: { success: true, view_count: @article.view_count }
  rescue => e
    Rails.logger.error "Error incrementing view: #{e.message}"
    render json: { success: false, error: 'Failed to update view count' }, status: :unprocessable_entity
  end

  def sync_firebase
    # Return current view count for Firebase sync
    render json: { 
      success: true, 
      article_id: @article.id,
      view_count: @article.view_count 
    }
  rescue => e
    Rails.logger.error "Error syncing Firebase: #{e.message}"
    render json: { success: false, error: 'Failed to sync' }, status: :unprocessable_entity
  end

  def bookmark
    user = current_user if defined?(current_user)
    bookmark = Bookmark.find_or_initialize_by(
      article_id: @article.id,
      user_id: user&.id
    )
    bookmark.last_position = params[:position]
    
    if bookmark.save
      render json: { success: true, bookmarked: true, bookmark_id: bookmark.id, message: 'Article bookmarked!' }
    else
      render json: { success: false, message: bookmark.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error bookmarking: #{e.message}"
    render json: { success: false, message: 'Failed to bookmark' }, status: :unprocessable_entity
  end
  
  def unbookmark
    user = current_user if defined?(current_user)
    bookmark = Bookmark.find_by(
      article_id: @article.id,
      user_id: user&.id
    )
    
    if bookmark
      if bookmark.destroy
        render json: { success: true, bookmarked: false, message: 'Bookmark removed!' }
      else
        render json: { success: false, message: 'Failed to remove bookmark' }, status: :unprocessable_entity
      end
    else
      # Not found is not an error, just means it wasn't bookmarked
      render json: { success: true, bookmarked: false, message: 'Bookmark already removed' }
    end
  rescue => e
    Rails.logger.error "Error removing bookmark: #{e.message}"
    render json: { success: false, message: 'Failed to remove bookmark' }, status: :unprocessable_entity
  end
  
  def check_bookmark
    user = current_user if defined?(current_user)
    bookmark = Bookmark.find_by(
      article_id: @article.id,
      user_id: user&.id
    )
    
    render json: { 
      bookmarked: bookmark.present?,
      bookmark_id: bookmark&.id
    }
  rescue => e
    Rails.logger.error "Error checking bookmark: #{e.message}"
    render json: { bookmarked: false }, status: :unprocessable_entity
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_not_found
    flash[:alert] = "Article not found."
    redirect_to root_path
  end
end

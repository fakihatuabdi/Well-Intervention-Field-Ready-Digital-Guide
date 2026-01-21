class HandbookController < ApplicationController
  def index
  end

  def general_knowledge
    @articles = Article.published
                      .by_category('general_knowledge')
                      .order(:title)
                      .page(params[:page])
                      .per(12)
  rescue => e
    Rails.logger.error "Error loading general knowledge: #{e.message}"
    flash.now[:alert] = "An error occurred loading articles."
    @articles = Article.none.page(params[:page])
  end

  def wk_rokan
    # TODO: Make divisions dynamic from database
    @divisions = ['Rig Hub', 'Coming Soon - Division 2', 'Coming Soon - Division 3']
  end

  def rig_hub
    @articles = Article.published
                      .by_category('zona_rokan')
                      .by_subcategory('rig_hub')
                      .order(:title)
                      .page(params[:page])
                      .per(12)
  rescue => e
    Rails.logger.error "Error loading rig hub articles: #{e.message}"
    flash.now[:alert] = "An error occurred loading articles."
    @articles = Article.none.page(params[:page])
  end
end

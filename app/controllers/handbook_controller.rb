class HandbookController < ApplicationController
  PER_PAGE = 30

  def index
  end

  def general_knowledge
    @articles = section_articles(Article.by_category("general_knowledge"))
  rescue StandardError => e
    Rails.logger.error "Error loading general knowledge: #{e.message}"
    flash.now[:alert] = "An error occurred loading articles."
    @articles = Article.none.page(params[:page])
  end

  def wk_rokan
    @rig_hub_count = Article.published.by_category("zona_rokan").by_subcategory("rig_hub").count
  rescue StandardError => e
    Rails.logger.error "Error loading Zona Rokan: #{e.message}"
    @rig_hub_count = 0
  end

  def rig_hub
    @articles = section_articles(Article.by_category("zona_rokan").by_subcategory("rig_hub"))
  rescue StandardError => e
    Rails.logger.error "Error loading rig hub articles: #{e.message}"
    flash.now[:alert] = "An error occurred loading articles."
    @articles = Article.none.page(params[:page])
  end

  private

  def section_articles(scope)
    scope.published.in_reading_order.page(params[:page]).per(PER_PAGE)
  end
end

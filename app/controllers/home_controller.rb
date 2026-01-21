class HomeController < ApplicationController
  def index
    @case_studies = CaseStudy.published.recent
    @popular_articles = Article.published.popular
    @updates = Update.published.recent
  rescue => e
    Rails.logger.error "Error loading home page: #{e.message}"
    flash.now[:alert] = "Some content could not be loaded. Please try again."
    @case_studies = []
    @popular_articles = []
    @updates = []
  end
end

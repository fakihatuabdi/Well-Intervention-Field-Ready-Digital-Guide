class HomeController < ApplicationController
  def index
    @case_studies = CaseStudy.published.recent
    # Get all published articles, will be sorted by Firebase counts on frontend
    @popular_articles = Article.published.limit(20) # Get more than 5 to allow sorting
    @updates = Update.published.recent
  end
end

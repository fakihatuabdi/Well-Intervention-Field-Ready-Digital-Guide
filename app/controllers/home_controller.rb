class HomeController < ApplicationController
  def index
    @case_studies = CaseStudy.published.recent
    @popular_articles = Article.published.popular
    @updates = Update.published.recent
  end
end

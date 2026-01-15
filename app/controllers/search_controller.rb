class SearchController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @articles = Article.published.search_by_all(@query).page(params[:page])
    else
      @articles = Article.none
      @query = nil
    end
  end
end

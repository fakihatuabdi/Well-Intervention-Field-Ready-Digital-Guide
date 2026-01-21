class SearchController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @articles = Article.published
                        .search_by_all(@query)
                        .page(params[:page])
                        .per(10)
    else
      @articles = Article.none.page(params[:page])
      @query = nil
    end
  rescue => e
    Rails.logger.error "Search error: #{e.message}"
    flash.now[:alert] = "An error occurred during search. Please try again."
    @articles = Article.none.page(params[:page])
    @query = params[:query]
  end
end

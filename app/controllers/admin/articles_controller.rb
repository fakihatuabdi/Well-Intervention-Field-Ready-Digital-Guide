module Admin
  class ArticlesController < BaseController
    before_action :set_article, only: %i[edit update]

    def index
      scope = Article.order(:category, :subcategory, :position, :title)
      scope = scope.by_category(params[:category]) if params[:category].present?
      scope = scope.search_by_all(params[:q]) if params[:q].present?
      @articles = scope.page(params[:page]).per(50)
    end

    def new
      @article = Article.new(published: false, category: params[:category].presence || "general_knowledge")
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        audit!("article.create", target: @article)
        redirect_to edit_admin_article_path(@article), notice: "Article created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @article.update(article_params)
        audit!("article.update", target: @article, details: change_summary(@article))
        redirect_to edit_admin_article_path(@article), notice: "Article saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      permitted = params.require(:article).permit(:title, :summary, :content, :category, :subcategory, :position, :published)
      permitted[:subcategory] = permitted[:category] == "zona_rokan" ? "rig_hub" : nil if permitted.key?(:category)
      permitted
    end
  end
end

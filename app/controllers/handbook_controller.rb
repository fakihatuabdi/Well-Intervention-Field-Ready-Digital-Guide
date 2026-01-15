class HandbookController < ApplicationController
  def index
  end

  def general_knowledge
    @articles = Article.published.by_category('general_knowledge').order(:title)
  end

  def wk_rokan
    @divisions = ['Rig Hub', 'Coming Soon - Division 2', 'Coming Soon - Division 3']
  end

  def rig_hub
    @articles = Article.published.by_category('wk_rokan').by_subcategory('rig_hub').order(:title)
  end
end

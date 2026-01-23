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
  
  # API endpoint for live search suggestions
  def suggestions
    query = params[:query].to_s.strip.downcase
    
    return render json: { articles: [], menus: [] } if query.length < 2
    
    # Search articles
    articles = Article.published
                     .search_by_all(query)
                     .limit(6)
                     .map { |a| 
                       { 
                         id: a.id, 
                         title: a.title, 
                         category: a.category,
                         subcategory: a.subcategory,
                         type: 'article',
                         url: article_path(a)
                       } 
                     }
    
    # Search menus and features
    menus = search_menus_and_features(query)
    
    render json: { articles: articles, menus: menus }
  rescue => e
    Rails.logger.error "Search suggestions error: #{e.message}"
    render json: { articles: [], menus: [], error: 'Failed to fetch suggestions' }, status: :internal_server_error
  end
  
  private
  
  def search_menus_and_features(query)
    menu_items = [
      { title: 'Home', description: 'Dashboard and Overview', url: home_path, icon: 'home', keywords: ['home', 'dashboard', 'main', 'overview', 'beranda'] },
      { title: 'Handbook', description: 'Comprehensive Operation Guide', url: handbook_path, icon: 'book', keywords: ['handbook', 'guide', 'manual', 'panduan', 'buku'] },
      { title: 'General Knowledge', description: 'Fundamental Concepts', url: handbook_general_knowledge_path, icon: 'book-open', keywords: ['general', 'knowledge', 'fundamental', 'basic', 'pengetahuan', 'dasar'] },
      { title: 'Zona Rokan Operation', description: 'Specific Operational Guidelines', url: handbook_wk_rokan_path, icon: 'map', keywords: ['zona', 'rokan', 'operation', 'wk', 'area', 'division'] },
      { title: 'Rig Hub', description: 'Rig Hub Division Articles', url: handbook_rig_hub_path, icon: 'wrench', keywords: ['rig', 'hub', 'division', 'drilling'] },
      { title: 'Search', description: 'Search Articles and Content', url: search_path, icon: 'search', keywords: ['search', 'find', 'cari', 'pencarian'] },
      { title: 'Calculator', description: 'Well Intervention Calculators', url: calculator_path, icon: 'calculator', keywords: ['calculator', 'calculation', 'kalkulator', 'hitung', 'compute'] },
      { title: 'AI Chat Bot', description: 'Interactive Q&A Assistant', url: chat_bot_path, icon: 'chat', keywords: ['chat', 'bot', 'ai', 'assistant', 'question', 'answer', 'tanya', 'jawab'] },
      { title: 'Bookmarks', description: 'Your Saved Articles', url: bookmarks_path, icon: 'bookmark', keywords: ['bookmark', 'saved', 'favorite', 'tersimpan', 'favorit'] }
    ]
    
    menu_items.select do |item|
      item[:title].downcase.include?(query) ||
      item[:description].downcase.include?(query) ||
      item[:keywords].any? { |k| k.include?(query) }
    end.map do |item|
      {
        title: item[:title],
        description: item[:description],
        type: 'menu',
        icon: item[:icon],
        url: item[:url]
      }
    end
  end
end

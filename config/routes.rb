Rails.application.routes.draw do
  root 'home#index'
  
  # Home
  get 'home', to: 'home#index'
  
  # Handbook
  get 'handbook', to: 'handbook#index'
  get 'handbook/general_knowledge', to: 'handbook#general_knowledge'
  get 'handbook/wk_rokan', to: 'handbook#wk_rokan'
  get 'handbook/rig_hub', to: 'handbook#rig_hub'
  
  # Articles
  resources :articles, only: [:show] do
    member do
      post :increment_view
      post :bookmark
    end
  end
  
  # Search
  get 'search', to: 'search#index'
  
  # Calculator
  get 'calculator', to: 'calculator#index'
  
  # AI Chat Bot
  get 'chat_bot', to: 'chat_bot#index'
  post 'chat_bot/send_message', to: 'chat_bot#send_message'
  
  # Bookmarks
  get 'bookmarks', to: 'bookmarks#index'
  delete 'bookmarks/:id', to: 'bookmarks#destroy', as: 'bookmark'
  
  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check
end

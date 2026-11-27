Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # Admin area (role "admin" only)
  namespace :admin do
    root "dashboard#index"
    resources :articles, except: [:show, :destroy]
    resources :updates, except: [:show]
    resources :case_studies, except: [:show]
    resources :users, except: [:show, :destroy] do
      member do
        patch :approve
        patch :unlock
      end
    end
    resources :audit_events, only: [:index]
  end
  root 'home#index'
  
  # Home
  get 'home', to: 'home#index'
  
  # Handbook
  get 'handbook', to: 'handbook#index'
  get 'handbook/general_knowledge', to: 'handbook#general_knowledge'
  get 'handbook/wk_rokan', to: 'handbook#wk_rokan'
  get 'handbook/rig_hub', to: 'handbook#rig_hub'
  
  # Articles
  resources :articles, only: [:index, :show] do
    member do
      post :increment_view
      post :bookmark
      delete :unbookmark
      get :check_bookmark
    end
  end
  
  # Search
  get 'search', to: 'search#index'
  get 'search/suggestions', to: 'search#suggestions'
  
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

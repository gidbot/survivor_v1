require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services

    get '/edit_players', to: 'data#edit_players'
    post '/update_players', to: 'data#update_players'

    get '/edit_stats', to: 'data#edit_stats'
    post '/update_stats', to: 'data#update_stats'

    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'

  get :join_league, to: "leagues#join"
  patch :join_league, to: "leagues#add_user", as: :add_user_to_league
  resources :leagues, except: [:destroy]
  resources :teams, execept: [:destroy, :index]
  resources :rosters, execept: [:destroy]
  resources :users, except: [:destroy]
end

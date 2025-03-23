Rails.application.routes.draw do
  get "pages/profile"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "competitions#index"
  get "challenges" => "pages#challenges"
  get "shop" => "pages#shop"


  resources :bets
  resources :competitions, only: [ :index, :show ] do
    resources :events, only: [ :index ] do
    end
  end
  resources :events, only: [ :show ] do
    get :odds, on: :member
    get :played, on: :collection
    get :finished, on: :collection
    resources :comments, except: [ :destroy ]
  end
  resources :comments, only: [ :destroy ]
  resources :odds, only: [ :index, :show ]
  resources :scores, only: [ :index, :show ]

  resources :friendships, only: [ :create, :update, :destroy ]
  resource :user, only: [ :show ] do
    get :profile, on: :member
  end
  resources :users, only: [] do
    get :search, on: :collection
    get :ranking, on: :collection
    get :ranking_friends, on: :collection
    get :friends, on: :collection
  end

  namespace :admin do
    resources :competitions
    resources :events
    resources :odds
    resources :scores
    resources :users
    resources :bets
  end
end

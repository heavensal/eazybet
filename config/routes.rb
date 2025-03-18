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
  get "profile" => "pages#profile"

  resources :bets
  resources :events, only: [ :index, :show ] do
    resources :comments, except: [ :destroy ]
  end
  resources :comments, only: [ :destroy ]
  resources :odds, only: [ :index, :show ]
  resources :competitions, only: [ :index, :show ]
  resources :scores, only: [ :index, :show ]

  namespace :admin do
    resources :competitions
    resources :events
    resources :odds
    resources :scores
    resources :users
    resources :bets
  end
end

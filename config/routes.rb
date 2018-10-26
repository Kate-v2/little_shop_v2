Rails.application.routes.draw do

  root "welcome#index"

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile',   to: 'users#show'
  get '/merchants', to: 'user#index'

  # get '/dashboard', to: 'users#index'
  resources :items

  resources :users, only: [:new, :create] do
    resources :items, only: [:new, :create]
  end






end

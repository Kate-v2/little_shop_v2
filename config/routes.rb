Rails.application.routes.draw do

  root "welcome#index"

  get '/register',  to: 'users#new'
  post '/register', to: 'users#create'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/cart', to: 'cart#index'

  get '/profile',   to: 'users#show'
  get '/dashboard', to: 'dashboard#index'

  # something not quite right with this path
  get '/merchants', to: 'users#index'

  # get '/dashboard', to: 'users#index'
  resources :items, only: [:index]

  resources :users, only: [:new, :create] do
    resources :items, only: [:new, :create]
  end






end

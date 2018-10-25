Rails.application.routes.draw do


  # get '/dashboard', to: 'users#index'
  resources :items
  resources :users, only: [:new, :create] do
    resources :items, only: [:new, :create]
  end


  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/profile', to: 'users#show'


end

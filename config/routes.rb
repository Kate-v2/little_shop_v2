Rails.application.routes.draw do

  root "welcome#index"

  get '/register',  to: 'users#new'
  post '/register', to: 'users#create'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/add_item', to: 'cart#create'
  get '/update_item', to: 'cart#update'
  get '/delete_cart', to: 'cart#destroy'
  # get '/destroy_item', to: 'cart#destroy'
  get '/delete_item', to: 'cart#destroy'

  get '/cart', to: 'cart#index'

  get '/dashboard', to: 'dashboards#index'
  get '/profile',   to: 'users#show'
  get '/profile/orders', to:'orders#index'
  # namespace :profile do
  #   resources :orders, only:[:index]
  # end

  # something not quite right with this path
  get '/merchants', to: 'users#index'

  # get '/dashboard', to: 'users#index'
  resources :items, only: [:index, :new, :show]

  resources :users, only: [:new, :create, :edit, :update] do
    resources :items, only: [:new, :create]
  end


end

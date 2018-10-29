Rails.application.routes.draw do

  root "welcome#index"

  get '/register',  to: 'users#new'
  post '/register', to: 'users#create'

  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/add_item',    to: 'cart#create'
  get '/update_item', to: 'cart#update'
  get '/delete_item', to: 'cart#destroy'
  #add destroy_item path to remove from database


  get '/cart',     to: 'cart#index'
  get '/checkout', to: 'orders#create'

  get '/dashboard',        to: 'dashboard#index'
  get '/dashboard/orders', to: 'orders#index',    as: 'dashboard_orders'

  resources :orders, only: [:index, :show]

  get '/profile',                   to: 'users#show'
  get '/profile/orders',            to: 'orders#index'
  get '/profile/orders/:id',        to: 'orders#show',    as: 'profile_order'
  get '/profile/orders/:id/cancel', to: 'orders#destroy', as: 'cancel_order'
  # namespace :profile do
  #   resources :orders, only:[:index, :show]
  # end

  # something not quite right with this path
  get '/merchants', to: 'users#index'

  # get '/dashboard', to: 'users#index'
  resources :items, only: [:index, :new, :show]

  resources :users, only: [:new, :create] do
    resources :items, only: [:new, :create]
  end






end

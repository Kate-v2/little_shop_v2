Rails.application.routes.draw do

  root "welcome#index"

  get '/register',    to: 'users#new'
  post '/register',   to: 'users#create'

  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  get '/logout',      to: 'sessions#destroy'

  get '/cart',        to: 'cart#index'
  get '/add_item',    to: 'cart#create'
  get '/update_item', to: 'cart#update'
  get '/delete_cart', to: 'cart#destroy'
  # get '/destroy_item', to: 'cart#destroy'
  get '/delete_item', to: 'cart#destroy'
  #add destroy_item path to remove from database

  get '/merchants',            to: 'users#index'
  get '/merchants/:id/items',  to: 'dashboards#show',  as: 'merchant_items'
  get '/merchants/:id/items/new',  to: 'dashboards#new',   as: 'merchant_items_new'
  get '/merchants/:id/orders', to: 'orders#index',     as: 'merchant_orders'
  get '/merchants/:user_id/orders/:id', to: 'orders#show', as: 'merchant_order'
  get '/merchants/edit',   to: 'users#edit',       as: 'merchant_edit'

  get '/dashboard',            to: 'dashboards#index'
  get '/dashboard/items',      to: 'dashboards#show',  as: 'dashboard_items'
  get '/dashboard/items/new',  to: 'dashboards#new',   as: 'dashboard_items_new'
  # get '/dashboard/orders',     to: 'orders#index',     as: 'dashboard_orders'
  # get '/dashboard/fulfill',    to: 'orders#update',    as: 'fulfillment'

  get '/users',   to: 'admin/users#index'
  # get '/users',   to: 'admin/users#edit'

  get '/checkout', to: 'orders#create'


  # get '/dashboard',         to: 'dashboard#index'
  get '/dashboard/orders',  to: 'orders#index',   as: 'dashboard_orders'

  # get '/profile/orders/:id/cancel', to: 'orders#destroy', as: 'cancel_order'
  get '/orders/:id/cancel',  to: 'orders#destroy', as: 'cancel_order'
  get '/orders/fulfill', to: 'orders#update',  as: 'fulfillment'

  post '/activate', to: 'users#toggle'

  get '/upgrade_downgrade', to: 'users#update'

  resources :orders, only: [:index, :show]


  get '/profile',                   to: 'users#show'
  get '/profile/edit',              to: 'users#edit',     as: 'profile_edit'
  get '/profile/orders',            to: 'orders#index'
  get '/profile/orders/:id',        to: 'orders#show',    as: 'profile_order'

  get '/merchants/:id', to: 'dashboards#index', as: 'merchant_show'
  # namespace :profile do
  #   resources :orders, only:[:index, :show]
  # end

  # something not quite right with this path
  get '/merchants', to: 'users#index'

  # get '/dashboard', to: 'users#index'
  resources :items, only: [:index, :new, :show, :edit, :update]

  resources :orders, only: [:index, :show]

  resources :users, only: [:new, :create, :edit, :update, :show] do
    resources :items, only: [:new, :create]
  end


  namespace :admin do
    resources :items
    resources :orders
  end

  namespace :merchant do
    resources :items
    resources :orders
  end

end

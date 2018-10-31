Rails.application.routes.draw do

  root "welcome#index"

  get  '/register',  to: 'users#new'
  post '/register',  to: 'users#create'

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  get '/cart',     to: 'cart#index'
  get '/checkout', to: 'orders#create'

  get '/add_item',    to: 'cart#create'
  get '/update_item', to: 'cart#update'
  get '/delete_item', to: 'cart#destroy'
  get '/delete_cart', to: 'cart#destroy'
  # get '/destroy_item', to: 'cart#destroy'

  #add destroy_item path to remove from database



  resources :orders, only: [:index, :show]
  # get '/profile/orders/:id/cancel', to: 'orders#destroy', as: 'cancel_order'
  get '/orders',             to: 'orders#index',   as: 'orders_path'
  get '/orders/:id',         to: 'orders#show',    as: 'order_path'
  get '/orders/:id/cancel',  to: 'orders#destroy', as: 'cancel_order'
  get '/orders/fulfill',     to: 'orders#update',  as: 'fulfillment'


  # --- Viewing Users ---
  get '/dashboard',           to: 'dashboards#index'
  # dashboard#index should really be dashboard#show
  get '/dashboard/items',     to: 'dashboards#show',  as: 'dashboard_items'
  # dashboard items should really point to items show
  get '/dashboard/items/new', to: 'dashboards#new',   as: 'dashboard/items/new'
  get '/dashboard/orders',    to: 'orders#index',     as: 'dashboard_orders'
  # I WANT TO BE ABLE TO DO ---
  get '/dashboard/orders/:id',to: 'orders#show',      as: 'dashboard_order'
  # --- THIS ^

  get '/profile',             to: 'users#show'
  get '/profile/edit',        to: 'users#edit',       as: 'profile_edit'
  get '/profile/orders',      to: 'orders#index'
  get '/profile/orders/:id',  to: 'orders#show',      as: 'profile_order'

  get '/users',               to: 'admin/users#index'

  get '/merchants',                     to: 'users#index'
  get '/merchants/:id',                 to: 'dashboards#index', as: 'merchant_show'
  get '/merchants/:user_id/orders',     to: 'orders#index',     as: 'merchant_orders'
  get '/merchants/:user_id/orders/:id', to: 'orders#show',      as: 'merchant_order'


  # --- Admin Responsibilities ---

  post '/activate',         to: 'users#toggle'
  get '/upgrade_downgrade', to: 'users#update'

  # namespace :profile do
  #   resources :orders, only:[:index, :show]
  # end

  resources :items, only: [:index, :new, :show, :edit, :update]

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

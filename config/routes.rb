Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/dashboard', to: 'users#index'
  resources :items
  resources :users, only: [:new, :create, :show] do
    resources :items, only: [:new, :create]
  end
end

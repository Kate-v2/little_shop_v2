Rails.application.routes.draw do
  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/profile', to: 'profile/users#index'


  resources :users, only: [:new, :create]

  namespace :profile do
    resources :profile, only: [:index]
  end
end

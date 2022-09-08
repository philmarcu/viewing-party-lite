# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/', to: 'application#home'
  root 'application#home'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:show] do
    get '/movies/:movie_id/event/new', to: 'events#new'
    # get '/dashboard', to: 'users#show'
    get '/discover', to: 'users#discover'
    post '/discover', to: 'movies#index'
    resources :movies, only: [:show, :index]
  end

  post '/users/:user_id', to: 'events#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
end

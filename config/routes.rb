Rails.application.routes.draw do
  get 'contacts/new'
  get 'posts/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'top_next', to: 'static_pages#next'
  get '/users', to: 'users#new' 
  root 'static_pages#home'
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :notifications, only: :index
  resources :users
  resources :posts do
    resources :comments
  end
  

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  resources :contacts, only: [:new, :create]
end

Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy]
  resources :comments
  resources :ratings
  root 'pages#index'
  resources :categories
  resources :recipes
  resources :users, except: [:new]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end

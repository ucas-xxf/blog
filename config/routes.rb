Rails.application.routes.draw do
  root 'static_pages#home'
  #match '/users/showuser/:id',to: 'users#showuser', via:'get'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/alluser', to: 'users#alluser'
  get '/users/showuser/:id', to: 'users#showuser'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  get '/microposts/:id', to: 'microposts#destroy'
  resources :users do
    member do
      get :following, :followers, 'showuser'
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

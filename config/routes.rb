Rails.application.routes.draw do
  
  devise_for :sellers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers

  root "flipkart#index"
  resources :payments
  resources :cart_products
  resources :carts
  resources :order_products
  resources :orders
  resources :addresses
  resources :products
  resources :wallets
  resources :sellers
  resources :categories
  resources :customers
  resource :card, only:[:show]

  resources :flipkart, only:[:index, :show]
  post 'order_products/place_order', to: 'order_products#place_order'
  get 'sessions/myaccount', to: 'sessions#myaccount'
  get 'sessions/sellersaccount', to: 'sessions#sellersaccount'
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/welcome'
  #get 'sessions/login', to: 'sessions#new'   
  #post 'sessions/login', to: 'sessions#create'
  #get 'flipkart/signup', to: "customers#new"
  #get 'sessions/logout', to: 'sessions#logout'

end

Rails.application.routes.draw do
  
  devise_for :customers
  #get 'card/show'

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

=begin   
  #get 'flipkart/index'
  #get 'flipkart/show'
=end

  resources :flipkart, only:[:index, :show]
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/welcome'
  #get 'sessions/login', to: 'sessions#new'   
  #post 'sessions/login', to: 'sessions#create'
  #get 'flipkart/signup', to: "customers#new"
  #get 'sessions/logout', to: 'sessions#logout'
  post 'order_products/place_order', to: 'order_products#place_order'
  post 'home/place_order', to: 'home#place_order'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

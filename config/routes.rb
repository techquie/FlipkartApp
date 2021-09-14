Rails.application.routes.draw do
=begin
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
      :authorized_applications
  end
=end

  use_doorkeeper
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
  get '/sessions/viewproduct', to: 'sessions#viewproduct'
  get '/sessions/addproduct', to: 'sessions#addproduct'
  post '/wallets/updatebalance', to: 'wallets#updatebalance'
  get 'sessions/view_orders/:id', to: 'sessions#view_orders'
  post '/sessions/add_product', to: 'sessions#add_product'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :customers
      resources :sellers
      resources :products

      put "customer/add_to_cart", to: "customers#add_to_cart"
      post "customer/place_order", to: "customers#place_order"
      get "customer/view_orders", to: "customers#view_orders"
    end
  end

end

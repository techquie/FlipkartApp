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
  resources :image_elements
  resource :card, only:[:show]
#=begin
  resources :accounts do
    collection {get :viewproduct}
    collection {post :import}
  end
#=end
  resources :flipkart, only:[:index, :show]
  post 'order_products/place_order', to: 'order_products#place_order'
  get 'sessions/myaccount', to: 'sessions#myaccount'
  get 'sessions/sellersaccount', to: 'sessions#sellersaccount'
  get '/sessions/viewproduct', to: 'sessions#viewproduct'
  get '/sessions/addproduct', to: 'sessions#addproduct'
  post '/wallets/updatebalance', to: 'wallets#updatebalance'
  get 'sessions/view_orders/:id', to: 'sessions#view_orders'
  post '/sessions/add_product', to: 'sessions#add_product'
  get '/sessions/productorderhistory', to: 'sessions#productorderhistory'
  post '/order_products/order_payment', to: 'order_products#order_payment'
  get '/search', to: 'flipkart#search'
  get '/order_summary', to: 'order_products#order_summary'

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

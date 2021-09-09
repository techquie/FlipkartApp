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
  get '/sessions/viewproduct', to: 'sessions#viewproduct'
  get '/sessions/addproduct', to: 'sessions#addproduct'
  post '/wallets/updatebalance', to: 'wallets#updatebalance'
  get 'sessions/view_orders/:id', to: 'sessions#view_orders'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :customers
      resources :sellers
    end
  end

end

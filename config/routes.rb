Rails.application.routes.draw do

  resources :recipes
  root "home#index"

  get "flipkart", to: "home#index"

  #get "/recipes/new", to: "recipe#new"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

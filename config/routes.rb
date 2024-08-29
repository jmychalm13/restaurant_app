Rails.application.routes.draw do
  resources :menu_items

  resources :orders

  resources :order_items

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"
end

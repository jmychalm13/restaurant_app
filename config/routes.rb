Rails.application.routes.draw do
  resources :menu_items

  resources :orders

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"
end

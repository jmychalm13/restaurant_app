Rails.application.routes.draw do
  resources :menu_items

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"
end

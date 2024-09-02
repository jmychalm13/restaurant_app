Rails.application.routes.draw do
  resources :menu_items

  resources :orders

  resources :order_items

  resources :users, only: [:create, :show]

  post "/sessions" => "sessions#create"
end

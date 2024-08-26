Rails.application.routes.draw do
  resources :menu_items
  
  post "/users" => "users#create"
end

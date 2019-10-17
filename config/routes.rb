Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "homepages#index"
  resources :works
  
  resources :users
  get "/login", to: "users#login_form", as: "login_form"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  
  resources :homepages, only: [:index]
  
end

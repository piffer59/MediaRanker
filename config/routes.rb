Rails.application.routes.draw do
  root to: "homepages#index"

  get "homepages/index"
  post "/votes/:id/upvote", to: "votes#upvote", as: "upvote"
  resources :works
  resources :homepages, only: [:index]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :users, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

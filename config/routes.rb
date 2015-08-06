Rails.application.routes.draw do
  devise_for :users
  root "books#index"
  get "about", to: "static_pages#about"
end

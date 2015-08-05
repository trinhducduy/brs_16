Rails.application.routes.draw do
  devise_for :users
  root "books#index"
  get "about", to: "static_pages#about"

  namespace :admin do
    root "books#index"
    resources :categories
  end
end

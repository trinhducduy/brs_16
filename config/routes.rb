Rails.application.routes.draw do
  devise_for :users
  mount Bootsy::Engine, at: "/bootsy", as: "bootsy"
  root "books#index"
  get "about", to: "static_pages#about"

  namespace :admin do
    root "books#index"
    resources :categories
    resources :books
  end
end

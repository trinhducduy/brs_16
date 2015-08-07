Rails.application.routes.draw do
  devise_for :users
  mount Bootsy::Engine, at: "/bootsy", as: "bootsy"
  root "books#index"
  get "about", to: "static_pages#about"

  resources :requests, only: [:new, :create]
  resources :books, only: [:index, :show, :update]

  namespace :admin do
    root "books#index"
    resources :categories
    resources :books, except: [:show]
  end
  resources :books, only:[:index, :show]
end

Rails.application.routes.draw do
  devise_for :users
  mount Bootsy::Engine, at: "/bootsy", as: "bootsy"
  root "books#index"
  get "about", to: "static_pages#about"

  resources :requests, only: [:new, :create, :update]
  resources :users, only: [:update, :edit, :show, :index]
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy, :index]

  resources :books, only: [:index, :show] do
    resource :user_book, only: [:create, :update]
    resources :reviews, except: [:index, :show]
  end

  resources :activities, only: [] do
    resource :activity_like, only: [:create, :destroy]
  end

  namespace :admin do
    root "books#index"
    resources :categories
    resources :books, except: [:show]
    resources :users, only: [:index, :destroy]
    resources :requests, only: [:index, :update, :destroy]
  end
end

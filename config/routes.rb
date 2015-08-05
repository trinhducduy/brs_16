Rails.application.routes.draw do
  root "books#index"
  get "about", to: "static_pages#about"
end

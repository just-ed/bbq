Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :events
  resources :users, only: [:show, :edit, :update]
  resources :comments, only: [:create, :destroy]
end

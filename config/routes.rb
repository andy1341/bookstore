Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  get 'users/show', as: 'user'
  resources :books, only: [:show]
  resources :categories, only: [:show]
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

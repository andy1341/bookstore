Rails.application.routes.draw do
  get 'orders_items/create'

  get 'orders_items/update'

  get 'orders_items/destroy'

  get 'checkout' => 'carts#checkout', as: 'checkout'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  get 'users/show', as: 'user'
  resources :books, only: [:show]
  resources :categories, only: [:show]
  resources :authors
  resource  :cart, only: [:show]
  resources :orders_items, only: [:create, :update, :destroy]
  resources :orders, only: [:update]

end

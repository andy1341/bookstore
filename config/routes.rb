Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  get 'users/show', as: 'user'
  resources :books, only: [:show]
  resources :categories, only: [:show]
  resources :authors, only: [:show]
  resources :orders_items, only: [:create, :update, :destroy]
  resources :reviews, only: [:create]

  resource  :cart, only: [:show]
  get 'checkout' => 'carts#checkout', as: 'checkout'

  patch 'orders/make_order' => 'orders#make_order', as: 'make_order'
  resources :orders, only: [:update,:show]

end

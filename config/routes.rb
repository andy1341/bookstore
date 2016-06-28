Rails.application.routes.draw do
  get 'checkout' => 'carts#checkout', as: 'checkout'
  patch 'orders/make_order' => 'orders#make_order', as: 'make_order'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  get 'users/show', as: 'user'
  resources :books, only: [:show]
  resources :categories, only: [:show]
  resources :authors, only: [:show]
  resource  :cart, only: [:show]
  resources :orders_items, only: [:create, :update, :destroy]
  resources :orders, only: [:update,:show]
  resources :reviews, only: [:create]

end

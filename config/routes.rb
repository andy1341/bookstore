Rails.application.routes.draw do
  devise_for :users, controllers:
      { omniauth_callbacks: 'users/omniauth_callbacks',
        registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  get 'users/show', as: 'user_root'
  resources :books, only: [:show]
  resources :categories, only: [:show]
  resources :authors, only: [:show]
  resources :orders_items, only: [:create, :update, :destroy]
  resources :reviews, only: [:create]
  resources :orders, only: [:index, :show]
  resource :checkout, only: [:show, :update]
  resource  :cart, only: [:show]

  patch 'checkouts/make_order', as: 'make_order'
  patch 'coupons/apply', as: 'coupons'
end

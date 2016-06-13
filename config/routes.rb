Rails.application.routes.draw do
  root 'main_page#index'
  get 'main_page/index'

  resources :books
  resources :categories
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

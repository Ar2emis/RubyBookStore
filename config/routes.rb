Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  resources :books, only: [:index, :show]
  resource :address, only: [:update]
  resources :reviews, only: [:create]
  resources :cart_items, only: [:create, :destroy]
  get '/cart', to: 'cart_items#index'
  post '/coupon', to: 'cart_items#coupon'

  match '*path' => redirect('/'), via: [:get]
end

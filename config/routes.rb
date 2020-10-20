Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  devise_scope :user do
    resource :quick_registration, only: [:show, :create]
  end

  resources :books, only: [:index, :show]
  resources :reviews, only: [:create]
  resource :address, only: [:update]
  resource :cart, only: [:show, :update, :destroy]
  resource :checkout, only: [:show, :update]

  match '*path' => redirect('/'), via: [:get]
end

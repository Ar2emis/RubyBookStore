Rails.application.routes.draw do
  get 'reviews/create'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  resources :books, only: [:index, :show]
  resource :address, only: [:update]
  resources :reviews, only: [:create]

  match '*path' => redirect('/'), via: [:get]
end

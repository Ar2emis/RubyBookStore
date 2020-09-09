Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
 

  resources :books, only: [:index, :show]
end

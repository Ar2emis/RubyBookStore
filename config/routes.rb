Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                    registrations: 'registrations',
                                    sessions: 'sessions' }
  devise_scope :user do
    resource :quick_registration, only: %i[show create]
  end

  resources :books, only: %i[index show]
  resources :reviews, only: [:create]
  resource :address, only: [:update]
  resource :cart, only: %i[show update destroy]
  resource :checkout, only: %i[show update]
  resources :orders, only: %i[index show]

  get '*path' => redirect('/')
end

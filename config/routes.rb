Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                    registrations: 'registrations',
                                    sessions: 'sessions'
                                  }

  resources :books, only: [:index, :show]
  resources :reviews, only: [:create]
  resource :address, only: [:update]
  resource :cart, only: [:show, :update, :destroy]

  match '*path' => redirect('/'), via: [:get]
end

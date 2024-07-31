Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :categories, only: [:index, :create, :update, :edit, :show, :new]

  resources :posts do
    resources :comments
    resource :favorite, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Route pour le profil utilisateur
  get 'user_profil', to: 'users#profil', as: 'user_profil'
  patch 'update_profile', to: 'users#update_profile', as: 'update_profile'

  # Route pour les paramètres (settings)
  get 'user_settings', to: 'users#settings', as: 'user_settings'
end

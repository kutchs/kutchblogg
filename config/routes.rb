Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :categories

  resources :posts do
    resources :comments
    resource :favorite, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Route pour le profil utilisateur
  get 'user_profil', to: 'users#profil', as: 'user_profil'

end

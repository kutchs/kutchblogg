Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :categories

  resources :posts do
    resources :comments
    resource :favorite, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end


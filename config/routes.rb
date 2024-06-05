Rails.application.routes.draw do
  # Routes pour l'authentification des utilisateurs
  devise_for :users
  devise_scope :user do
    delete '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Route de recherche pour trouver des albums et des cartes
  get 'search', to: 'search#index'

  # Définir la racine de l'application
  root to: 'pages#home'

  # Routes pour les collections
  resources :collections, only: [:new, :create, :show, :edit, :update, :destroy]

  # Routes pour les ressources imbriquées : users -> collections -> albums -> cards
  resources :users, only: [] do
    resources :collections do
      resources :albums, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :pokemons, only: [:new, :create]
      end
    end
  end
end

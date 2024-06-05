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
  resources :collections, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :albums, only: [:new, :create]
  end

  resources :albums, only: [:show, :create, :edit, :update, :destroy]
  # Routes pour les pokemons
  resources :albums, only: [] do
    resources :album_pokemons, only: [:new, :create]
  end
end

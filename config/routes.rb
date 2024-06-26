Rails.application.routes.draw do
  # Routes pour l'authentification des utilisateurs
  devise_for :users
  devise_scope :user do
    delete "/users/sign_out", to: "devise/sessions#destroy"
  end

  # Route de recherche pour trouver des albums et des cartes
  get "search", to: "search#index"

  # Définir la racine de l'application
  root to: "pages#home"
  # delete 'collections/:collection_id/albums/:id', to: 'albums#destroy_collection_album', as: 'collection_album'

  # Routes pour les collections
  resources :collections, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :albums, only: [:new, :create]
  end

  delete "/album_pokemons", to: "album_pokemons#destroy_multiple"

  resources :albums, only: [:show, :edit, :update, :destroy]
  # Routes pour les pokemons
  resources :albums, only: [] do
    resources :album_pokemons, only: [:new, :create, :destroy] do
      resources :pokemons, only: [:show]
    end
  end

  resources :pokemons, only: [] do
    member do
      get :render_content
    end
    collection do
      get :search
    end
  end

  # get '/manifest.json', to: redirect('/assets/manifest.json')

end

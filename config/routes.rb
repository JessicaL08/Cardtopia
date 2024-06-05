Rails.application.routes.draw do
  # Routes pour l'authentification des utilisateurs
  get 'search/index'


  devise_for :users
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'

    resources :collections, only: [:new, :create, :show, :edit, :update, :destroy]
      # Routes pour les ressources imbriquées : users -> collections -> albums -> cards
      resources :users, only: [] do
        resources :collections do
          resources :albums, only: [:new, :create, :show, :edit, :update, :destroy] do
            resources :pokemons, only: [:new, :create, :show]
          end
        end
      end

devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Route de recherche pour trouver des albums et des cartes
  get 'search', to: 'search#index'
end

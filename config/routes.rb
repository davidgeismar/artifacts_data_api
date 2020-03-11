Rails.application.routes.draw do
  namespace :christies do
    resources :sales, only: [:create]
    resources :lots, only: [:create]
  end

  resources :lots, only: [:show]
  get "data/artist/:id", to: 'data#artist_data'
  get 'artists/string', to: 'artists#string_artist'
  resources :artists, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

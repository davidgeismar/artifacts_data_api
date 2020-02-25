Rails.application.routes.draw do
  namespace :christies do
    resources :sales, only: [:create]
    resources :lots, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

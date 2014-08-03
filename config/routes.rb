Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'ovens#index', as: :authenticated_root
  end

  root to: 'visitors#index'

  resources :ovens
end

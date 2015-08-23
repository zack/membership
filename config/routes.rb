Rails.application.routes.draw do
  root 'members#index'

  resources :members, only: [:index, :show]
  resources :teams, only: [:index, :show]
end

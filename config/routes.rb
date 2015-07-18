Rails.application.routes.draw do

  root 'members#index'

  get 'contact' => 'static#contact'

  resources :members
end

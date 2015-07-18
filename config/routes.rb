Rails.application.routes.draw do

  root 'members#index'

  get 'contact' => 'static#contact'

  get 'members/group'

  resources :members
end

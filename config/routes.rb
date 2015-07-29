Rails.application.routes.draw do

  get 'members/new'

  root 'members#index'

  get 'contact' => 'static#contact'

  get 'members/group'

  resources :members
end

Rails.application.routes.draw do

  get 'players/new'

  get 'emergency_contacts/new'

  get 'members/new'

  root 'members#index'

  get 'contact' => 'static#contact'

  get 'members/group'

  resources :members
end

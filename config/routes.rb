Rails.application.routes.draw do
  devise_for :users

  root 'db#index'

  get '*path'         => 'db#index'

  put  'members/(:id)'            => 'members#update',            as: 'member_update'
  post 'members/'                 => 'members#create',            as: 'member_create'

  put  'players/(:id)'            => 'players#update',            as: 'player_update'
  post 'players/'                 => 'players#create',            as: 'player_create'

  put  'emergency_contacts/(:id)' => 'emergency_contacts#update', as: 'emergency_contact_update'
  post 'emergency_contacts/'      => 'emergency_contacts#create', as: 'emergency_contact_create'
end

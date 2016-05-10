Rails.application.routes.draw do
  root 'db#index'

  get '*path'         => 'db#index'

  put 'members/(:id)'            => 'members#update',            as: 'member_update'
  put 'players/(:id)'            => 'players#update',            as: 'player_update'
  put 'emergency_contacts/(:id)' => 'emergency_contacts#update', as: 'emergency_contact_update'

end

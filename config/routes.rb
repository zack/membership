Rails.application.routes.draw do
  root 'members#index'

  get 'members'        => 'members#index'
  get 'members/:id'    => 'members#index'
  get 'members/*'      => 'members#index'

end

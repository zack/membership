Rails.application.routes.draw do

  get 'committee_members/new'

  get 'pillars/new'

  get 'committees/new'

  get 'person_jobs/new'

  get 'jobs/new'

  get 'team_captains/new'

  get 'team_players/new'

  get 'teams/new'

  get 'players/new'

  get 'emergency_contacts/new'

  get 'members/new'

  root 'members#index'

  get 'contact' => 'static#contact'

  get 'members/group'

  resources :members
end

Rails.application.routes.draw do
  root 'db#index'

  get '*path'       => 'db#index'

end

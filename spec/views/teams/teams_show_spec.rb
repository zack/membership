require 'rails_helper'

describe 'teams/show.html.haml' do
  before do
    assign(:fields, ['name', 'number'])
    assign(:team, Team.create(id: 1, name: 'Toaster City'))

    Player.create(id: 1, name: 'Burnt Bread', number: 1)
    TeamPlayer.create(team_id: 1, player_id: 1)
  end

  it 'displays the member information' do
    render

    expect(rendered).to have_selector 'tbody th', text: 'Name'
    expect(rendered).to have_selector 'tbody td', text: 'Burnt Bread'
  end
end

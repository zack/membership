require 'rails_helper'

describe 'teams/index.html.haml' do
  before do
    assign(:teams, [Team.create(name: 'Toaster City Toasters')])
  end

  it 'displays the team table' do
    render

    expect(rendered).to have_selector 'tbody th', text: 'name'
    expect(rendered).to have_selector 'tbody td', text: 'Toaster City Toasters'
  end
end


require 'rails_helper'

describe 'members/index.html.haml' do
  before do
    assign(:members, [Member.create(name: 'Xerxes')])
  end

  it 'displays the member table' do
    render

    expect(rendered).to have_selector 'tbody th', text: 'name'
    expect(rendered).to have_selector 'tbody td', text: 'Xerxes'
  end
end

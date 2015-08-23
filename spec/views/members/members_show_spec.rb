require 'rails_helper'

describe 'members/show.html.haml' do
  before do
    assign(:member, Member.create(name: 'Constantine'))
  end

  it 'displays the member information' do
    render

    expect(rendered).to have_selector 'tbody td', text: 'name'
    expect(rendered).to have_selector 'tbody td', text: 'Constantine'
  end
end

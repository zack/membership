require 'rails_helper'

describe MembersController do
  describe 'visit #index' do
    it 'renders the :index view' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe 'visit #show' do
    before do
      @member_id = Member.create(name: 'Constantine').id
    end

    it 'renders the :show view' do
      get :show, id: @member_id

      expect(response).to render_template :show
    end

  end
end

require 'rails_helper'

describe TeamsController do
  describe 'visit #index' do
    it 'renders the :index view' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe 'visit #show' do
    before do
      @team_id = Team.create(name: 'Water City Carafes').id
    end

    it 'renders the :show view' do
      get :show, id: @team_id

      expect(response).to render_template :show
    end

  end
end

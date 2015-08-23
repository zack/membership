class TeamsController < ApplicationController
  IGNORED_TEAM_KEYS = ['id', 'updated_at', 'created_at']

  def index
    @teams = Team.all
  end

  def show
    @fields = ['name', 'number']
    @team = Team.find(params[:id])
  end
end

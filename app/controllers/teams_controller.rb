class TeamsController < ApplicationController
  helper_method :teams
  respond_to :html

  def index
    respond_with teams
  end

  def teams
    @_teams ||= Team.all
  end

end

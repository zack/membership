class ApplicationController < ActionController::Base

  def setup_frontend_data
    @members = all_members
    @teams = all_teams
    @players = all_players
  end

  def all_members
    Member.all
  end

  def all_teams
    Team.all
  end

  def all_players
    Player.all
  end
end

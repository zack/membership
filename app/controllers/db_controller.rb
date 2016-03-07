class DbController < ApplicationController
  respond_to :html

  def index
    setup_frontend_data
  end

  def setup_frontend_data
    @members = all_members
    @teams = all_teams
    @players = all_players
  end

  def all_members
    Member.primary_load_data.to_json( :include =>
      [ :emergency_contacts, { :players => { :include => { :teams => { :only => [:name, :id]}}}}])
  end

  def all_teams
    Team.primary_load_data.to_json( :include =>
        { :players => { :include => { :member => { :only => :street_name}}}})
  end

  def all_players
    Player.all.to_json
  end
end

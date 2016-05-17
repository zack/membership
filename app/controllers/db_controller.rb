class DbController < ApplicationController
  respond_to :html

  def index
    setup_frontend_data
  end

  def setup_frontend_data
    @members = all_members
    @teams = all_teams
    @players = all_players
    @emergency_contacts = all_emergency_contacts
  end

  def all_members
    Member.all.to_json
  end

  def all_teams
    Team.all.to_json
  end

  def all_players
    Player.all.to_json
  end

  def all_emergency_contacts
    EmergencyContact.all.to_json
  end
end

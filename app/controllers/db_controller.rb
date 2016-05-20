class DbController < ApplicationController
  respond_to :html

  def index
    if user_signed_in?
      set_user_privileges
      setup_frontend_data
    else
      redirect_to new_user_session_path
    end
  end

  def set_user_privileges
    user_is_admin = current_user.username == 'admin'
    @admin_privileges = user_is_admin
  end

  def setup_frontend_data
    @members = all_members
    @teams = all_teams
    @players = all_players
    @emergency_contacts = all_emergency_contacts
  end

  def all_members
    if @admin_privileges
      Member.all.to_json
    else
      columns = Member.attribute_names - ['government_name']
      Member.select(columns).to_json
    end
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

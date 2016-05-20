class PlayersController < ApplicationController
  helper_method :players
  before_action :user_is_admin?, only: [:create, :update]

  respond_to :html

  def index
    respond_with players
  end

  def user_is_admin?
    current_user.username == 'admin'
  end

  def players
    @_players ||= Player.all
  end

  def create
    player = Player.create()
    player.update_attributes!(player_params)
    player.save
    render status: 201, json: player
  end

  def update
    player = Player.find(params[:player][:id])
    player.update_attributes!(player_params)
    render status: 201, json: player
  rescue Exception => e
    render status: 422, json: {errors: e.record.errors}
  end

  private

  def player_params
    params[:player].permit(
      :name,
      :number,
      :member_id,
      :team_id,
      :date_started,
      :date_ended,
      :active)
  end
end

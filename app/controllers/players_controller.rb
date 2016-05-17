class PlayersController < ApplicationController
  helper_method :players
  respond_to :html

  def index
    respond_with players
  end

  def players
    @_players ||= Player.all
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
      :date_started,
      :date_ended,
      :active)
  end
end

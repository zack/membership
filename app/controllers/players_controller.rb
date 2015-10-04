class PlayersController < ApplicationController
  helper_method :players
  respond_to :html

  def index
    respond_with players
  end

  def players
    @_players ||= Player.all
  end

end

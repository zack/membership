class TeamCaptain < ActiveRecord::Base
  has_one :team_player

  validates :team_player_id, presence: true, uniqueness: true
  validate :valid_date_ended

  def valid_date_ended
    errors.add :date_ended if :date_ended <= :date_started
  end
end

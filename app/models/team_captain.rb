class TeamCaptain < ActiveRecord::Base
  belongs_to :team_player

  validates :team_player_id, presence: true, uniqueness: true
end

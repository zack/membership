class TeamPlayer < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  has_one :team_captain

  validates_with DateValidator

  validates :team_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :team_id }
end

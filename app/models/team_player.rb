class TeamPlayer < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  has_one :team_captain

  validates :team_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :team_id }
  validate :valid_date_left

  def valid_date_left
    errors.add :date_left if :date_left <= :date_joined
  end
end

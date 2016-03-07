class Team < ActiveRecord::Base
  has_many :team_players
  has_many :players, through: :team_players

  validates_with DateValidator

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :primary_load_data, -> { includes(players: [ :member ]) }
end

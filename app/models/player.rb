class Player < ActiveRecord::Base
  belongs_to :member
  has_many :team_players
  has_many :teams, through: :team_players

  validates_with DateValidator

  validates :name, presence: true
  validates :number, presence: true, format: { with: /\A\d{1,4}\z/ }
end

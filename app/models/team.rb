class Team < ActiveRecord::Base
  has_many :players

  validates_with DateValidator

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :primary_load_data, -> { includes(players: [ :member ]) }
end

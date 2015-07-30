class Team < ActiveRecord::Base
  has_many :players, through: :team_players

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_date :date_ended, :after => :date_started,
                              :allow_nil => true,
                              :if => :date_started
end

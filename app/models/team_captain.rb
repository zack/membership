class TeamCaptain < ActiveRecord::Base
  belongs_to :team_player

  validates :team_player_id, presence: true, uniqueness: true
  validates_date :date_started
  validates_date :date_ended, :after => :date_started,
                              :allow_nil => true,
                              :if => :date_started
end

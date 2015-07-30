class Team < ActiveRecord::Base
  has_many :players, through :team_players

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :valid_date_ended

  def valid_date_ended
    errors.add :date_ended if :date_ended <= :date_started
  end
end

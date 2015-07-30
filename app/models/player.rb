class Player < ActiveRecord::Base
  belongs_to :member
  has_one :team, through :team_players

  validates :name, presence: true, uniqueness: { scope: :number }
  validates :number, presence: true
  validate :valid_number

  def valid_number
    errors.add :number unless :number.length <= 4 &&
                              :number.length >= 1 &&
                              :number =~ /\d/
  end
end

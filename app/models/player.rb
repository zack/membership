class Player < ActiveRecord::Base
  belongs_to :member
  has_one :team, through: :team_players

  validates :name, presence: true, uniqueness: { scope: :number,
    case_sensitive: false}
  validates :number, presence: true,
                     format: { with: /\A(?=[a-zA-Z]*\d)(?=[a-zA-Z]*).{1,4}\z/ }
end

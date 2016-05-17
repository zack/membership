class Player < ActiveRecord::Base
  belongs_to :member
  belongs_to :team

  validates_with DateValidator

  validates :name, presence: true
  validates :number, presence: true, format: { with: /\A\d{1,4}\z/ }
end

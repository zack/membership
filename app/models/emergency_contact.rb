class EmergencyContact < ActiveRecord::Base
  belongs_to :member

  validates :name, presence: true
  validates :phone_number, presence: true
  validate :valid_phone_number

  def valid_phone_number
    digits = :phone_number.delete('^0-9')
    errors.add :phone_number if digits.length != 10
  end
end

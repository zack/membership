class EmergencyContact < ActiveRecord::Base
  belongs_to :member

  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\d{10}/ }
end

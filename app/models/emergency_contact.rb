class EmergencyContact < ActiveRecord::Base
  belongs_to :member

  validates :name, presence: true
  validates :member_id, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/ }
end

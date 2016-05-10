class EmergencyContact < ActiveRecord::Base
  belongs_to :member

  validates :name, presence: true
  validates :member_id, presence: true
end

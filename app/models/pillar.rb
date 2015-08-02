class Pillar < ActiveRecord::Base
  has_many :committees

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

class Pillar < ActiveRecord::Base
  has_many :commitees

  validates :name, presence: true, uniqueness: { case_sensitive: :false }
end

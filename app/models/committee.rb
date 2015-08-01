class Committee < ActiveRecord::Base
  belongs_to :pillar
  has_many :jobs
  has_many :committee_members
  has_many :members, through: :committee_members

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

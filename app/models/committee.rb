class Committee < ActiveRecord::Base
  belongs_to :pillar
  has_many :jobs
  has_and_belongs_to_many :members

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

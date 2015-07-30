class Member < ActiveRecord::Base
  has_many :players
  has_many :emergency_contacts
  has_many :jobs, through: :member_jobs
  has_and_belongs_to_many :committees

  validates :name, presence: true
  validates :forum_handle, uniqueness: { case_sensitive: false }
  validates :wftda_id, uniqueness: true, numericality: { only_integer: true }
  validate :valid_year_left

  def valid_year_left
    errors.add :year_left if :year_left < :year_joined
  end
end

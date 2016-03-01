class Member < ActiveRecord::Base
  include NormalizeBlankValues

  has_many :players
  has_many :emergency_contacts
  has_many :member_jobs
  has_many :jobs, through: :member_jobs
  has_many :committee_members
  has_many :committees, through: :committee_members

  validates :name, presence: true
  validates :forum_handle, uniqueness: { case_sensitive: false },
                           allow_nil: true
  validates :wftda_id_number, uniqueness: true,
                              numericality:
                              { only_integer: true, allow_blank: true},
                              allow_nil: true
  validates :year_joined, numericality: { only_integer: true }, allow_nil: true
  validates :year_left, numericality: { only_integer: true }, allow_nil: true
  validates :year_left, numericality: {greater_than_or_equal_to: :year_joined},
                        if: :year_joined?, allow_nil: true
end

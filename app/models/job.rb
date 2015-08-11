class Job < ActiveRecord::Base
  belongs_to :committee
  has_many :member_jobs
  has_many :members, through: :member_jobs

  validates :name, presence: true
  validates :committee_id, presence: true
  validates :hours_per_week_lower, numericality: { only_integer: true }, allow_nil: true
  validates :hours_per_week_upper, numericality: { only_integer: true }, allow_nil: true
  validates :hours_per_week_upper,
    numericality: { greater_than_or_equal_to: :hours_per_week_lower },
    if: :hours_per_week_lower?,
    allow_nil: true
end

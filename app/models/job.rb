class Job < ActiveRecord::Base
  belongs_to :committee
  has_many :member_jobs
  has_many :members, through: :member_jobs

  validates :name, presence: true
  validates :committee_id, presence: true
  validates_date :date_started
  validates_date :date_ended, :after => :date_started,
                              :allow_nil => true,
                              :if => :date_started
end

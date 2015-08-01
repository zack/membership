class MemberJob < ActiveRecord::Base
  belongs_to :member
  belongs_to :job

  validates :job_id, presence: true, uniqueness: { scope: :member_id }
  validates :member_id, presence: true
  validates_date :date_started
  validates_date :date_ended, :after => :date_started,
                              :allow_nil => true,
                              :if => :date_started
end

class MemberJob < ActiveRecord::Base
  belongs_to :member
  belongs_to :job

  validates :job_id, presence: true, uniqueness: { scope: :member_id }
  validates :member_id, presence: true
end

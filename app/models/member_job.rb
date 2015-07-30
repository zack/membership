class MemberJob < ActiveRecord::Base
  belongs_to :member
  belongs_to :job

  validates :job_id, uniqueness: { scope: :member_id }
  validate :valid_date_ended

  def valid_date_ended
    errors.add :date_ended if :date_ended <= :date_started
  end
end

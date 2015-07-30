class CommitteeMember < ActiveRecord::Base
  belongs_to :committee
  belongs_to :member

  validates :member_id, uniqueness: { scope: :committee_id }
  validate :valid_date_ended

  def valid_date_ended
    errors.add :date_ended if :date_ended <= :date_started
  end
end

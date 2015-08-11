class CommitteeMember < ActiveRecord::Base
  belongs_to :committee
  belongs_to :member

  validates_with DateValidator

  validates :committee_id, presence: true
  validates :member_id, uniqueness: { scope: :committee_id }, presence: true
end

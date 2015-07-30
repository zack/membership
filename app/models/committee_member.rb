class CommitteeMember < ActiveRecord::Base
  belongs_to :committee
  belongs_to :member

  validates :member_id, uniqueness: { scope: :committee_id }
  validates_date :date_ended, :after => :date_started,
                              :allow_nil => true,
                              :if => :date_started
end

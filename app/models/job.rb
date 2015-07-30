class Job < ActiveRecord::Base
  belongs_to :committee
  has_one :member, through :member_jobs

  validates :name, presence: { case_sensitive: false }
  validate :valid_date_destroyed

  def valid_date_destroyed
    errors.add :date_destroyed if :date_destroyed <= :date_created
  end

end

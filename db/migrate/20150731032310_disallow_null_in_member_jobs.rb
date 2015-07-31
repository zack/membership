class DisallowNullInMemberJobs < ActiveRecord::Migration
  def change
    change_column_null :member_jobs, :member_id, false
    change_column_null :member_jobs, :job_id, false
  end
end

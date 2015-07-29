class CreateMemberJobs < ActiveRecord::Migration
  def change
    create_table :member_jobs do |t|
      t.references :member
      t.references :job

      t.date       :date_started
      t.date       :date_ended

      t.timestamps null: false
    end
    add_index :member_jobs, [:member_id, :job_id], :unique => true
  end
end

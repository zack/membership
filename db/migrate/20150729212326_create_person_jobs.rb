class CreatePersonJobs < ActiveRecord::Migration
  def change
    create_table :person_jobs do |t|
      t.references :person
      t.references :job

      t.date       :date_started
      t.date       :date_ended

      t.timestamps null: false
    end
    add_index :person_jobs, [:person_id, :job_id], :unique => true
  end
end

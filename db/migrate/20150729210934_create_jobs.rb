class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      belongs_to :committee

      t.string   :name, null: false
      t.boolean  :is_full_time
      t.integer  :hours_per_week
      t.date     :date_created
      t.date     :date_destroyed

      t.timestamps null: false
    end
  end
end

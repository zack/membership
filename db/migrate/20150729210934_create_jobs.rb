class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :committee, index: true

      t.string   :name, null: false
      t.boolean  :is_full_time
      t.integer  :hours_per_week
      t.date     :date_created
      t.date     :date_destroyed

      t.timestamps null: false
    end
  end
end

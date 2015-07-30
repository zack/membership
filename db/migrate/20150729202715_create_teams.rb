class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, unique: true, null: false
      t.date   :date_started
      t.date   :date_ended

      t.timestamps null: false
    end
  end
end

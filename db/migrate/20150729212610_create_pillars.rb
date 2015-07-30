class CreatePillars < ActiveRecord::Migration
  def change
    create_table :pillars do |t|
      t.string :name, unique: true, null: false

      t.timestamps null: false
    end
  end
end

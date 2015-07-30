class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.belongs_to :pillar, index: true

      t.string     :name, unique: true, null: false

      t.timestamps null: false
    end
  end
end

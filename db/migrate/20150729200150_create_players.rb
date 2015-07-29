class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :person

      t.string :number, null: false
      t.string :name, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
    add_index :person, [:number, :name], :unique => true
  end
end

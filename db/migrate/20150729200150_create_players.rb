class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :member

      t.string     :name, null: false
      t.string     :number, null: false
      t.date       :start_date
      t.date       :end_date

      t.timestamps null: false
    end
    add_index :players, [:name, :number], :unique => true
  end
end

class ChangePlayerIndex < ActiveRecord::Migration
  def change
    remove_index :players, [:name, :number]
    add_index :players, [:name, :number, :team_id], :unique => true
  end
end

class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.references :team, null: false, index: true
      t.references :player, null: false, index: true

      t.date       :date_joined
      t.date       :date_left

      t.timestamps null: false
    end
    add_index :team_players, [:team_id, :player_id], :unique => true
  end
end

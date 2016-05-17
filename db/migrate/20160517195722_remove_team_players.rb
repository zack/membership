class RemoveTeamPlayers < ActiveRecord::Migration
  def change
    drop_table :team_players
    drop_table :team_captains
    add_column :players, :team_id, :integer
    add_foreign_key :players, :teams
  end
end

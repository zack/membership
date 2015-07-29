class CreateTeamCaptains < ActiveRecord::Migration
  def change
    create_table :team_captains do |t|
      t.references :team_player, unique: true, null: false

      t.date       :date_started
      t.date       :date_ended

      t.timestamps null: false
    end
  end
end

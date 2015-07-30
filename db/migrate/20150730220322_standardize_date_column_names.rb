class StandardizeDateColumnNames < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
      t.rename :date_created, :date_started
      t.rename :date_destroyed, :date_ended
    end

    change_table :team_players do |t|
      t.rename :date_joined, :date_started
      t.rename :date_left, :date_ended
    end
  end
end

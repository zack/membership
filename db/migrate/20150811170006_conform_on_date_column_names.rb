class ConformOnDateColumnNames < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.rename :start_date, :date_started
      t.rename :end_date, :date_ended
    end
  end
end

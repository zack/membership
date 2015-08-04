class MakeUpperAndLowerBoundsForJobHours < ActiveRecord::Migration
  def change
    rename_column :jobs, :hours_per_week, :hours_per_week_lower
    add_column :jobs, :hours_per_week_upper, :integer
  end
end

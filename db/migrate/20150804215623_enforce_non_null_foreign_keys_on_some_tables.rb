class EnforceNonNullForeignKeysOnSomeTables < ActiveRecord::Migration
  def change
    change_column_null :committees, :pillar_id, false
    change_column_null :jobs, :committee_id, false
  end
end

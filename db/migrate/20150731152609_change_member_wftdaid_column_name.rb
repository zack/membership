class ChangeMemberWftdaidColumnName < ActiveRecord::Migration
  def change
    rename_column :members, :wftda_id, :wftda_id_number
  end
end

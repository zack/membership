class ModifyNamesOnMembers < ActiveRecord::Migration
  def change
    rename_column :members, :name, :street_name
    add_column :members, :government_name, :string
  end
end

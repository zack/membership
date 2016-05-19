class AddMemberOptions < ActiveRecord::Migration
  def change
    add_column :members, :official, :boolean
    add_column :members, :volunteer, :boolean
  end
end

class AddPronounsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :pronouns, :string
  end
end

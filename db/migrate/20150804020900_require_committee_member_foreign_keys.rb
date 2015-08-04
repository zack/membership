class RequireCommitteeMemberForeignKeys < ActiveRecord::Migration
  def change
    change_table :committee_members do |t|
      t.change :committee_id, :integer, :null => false
      t.change :member_id, :integer, :null => false
    end
  end
end

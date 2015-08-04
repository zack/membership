class RequireMemberIdOnEmergencyContact < ActiveRecord::Migration
  def change
    change_column :emergency_contacts, :member_id, :integer, :null => false
  end
end

class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.references :committee, index: true
      t.references :member, index: true

      t.date       :date_started
      t.date       :date_ended

      t.timestamps null: false
    end
    add_index :committee_members, [:committee_id, :member_id], :unique => true
  end
end

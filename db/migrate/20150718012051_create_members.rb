class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :legal_name
      t.string :derby_name
      t.string :email_address

      t.timestamps null: false
    end
  end
end

class AddEmailToMembers < ActiveRecord::Migration
  def change
    add_column :members, :email_address, :string
  end
end

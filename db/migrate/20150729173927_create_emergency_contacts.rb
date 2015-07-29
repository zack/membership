class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|

      t.belongs_to :person

      t.string :name
      t.string :phone_number
      t.text   :addres
      t.string :relationship

      t.timestamps null: false
    end
  end
end

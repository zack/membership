class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.belongs_to :person, index: true

      t.string :name, null: false
      t.string :phone_number, null: false
      t.text   :address
      t.string :relationship

      t.timestamps null: false
    end
  end
end

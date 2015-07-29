class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|

      t.references :emergency_contact

      t.string  :name
      t.string  :nickname
      t.string  :phone_number
      t.string  :forum_handle
      t.text    :address
      t.date    :date_of_birth

      t.string  :wftda_id
      t.string  :primary_insurance

      t.boolean :signed_wftda_waiver
      t.boolean :signed_wftda_confidentiality
      t.boolean :signed_league_bylaws
      t.boolean :purchased_wftda_insurance
      t.boolean :passed_wftda_test
      t.boolean :active
      t.boolean :google_doc_access

      t.integer :year_joined
      t.integer :year_left
      t.text    :reason_left

      t.timestamps null: false
    end
  end
end

class CompleteMemberModel < ActiveRecord::Migration
  def change
    add_column :members, :legal_name_first, :string
    add_column :members, :legal_name_last, :string
    add_column :members, :number, :string
    add_column :members, :wftda_number, :string
    add_column :members, :nickname, :string
    add_column :members, :group, :string
    add_column :members, :signed_wftda_waiver, :boolean
    add_column :members, :signed_wftda_confidentiality, :boolean
    add_column :members, :signed_league_bylaws, :boolean
    add_column :members, :wftda_id, :integer
    add_column :members, :forum_name, :string
    add_column :members, :year_joined, :integer
    add_column :members, :year_left, :integer
    add_column :members, :reason_left, :string
    add_column :members, :phone_number, :string
    add_column :members, :emergency_contact_name_first, :string
    add_column :members, :emergency_contact_name_last, :string
    add_column :members, :emergency_contact_phone, :string
    add_column :members, :emergency_contact_relation, :string
    add_column :members, :date_of_birth, :date
    add_column :members, :address_state, :string
    add_column :members, :address_street, :string
    add_column :members, :address_city, :string
    add_column :members, :address_zip, :string
    add_column :members, :primary_insurance, :string
    add_column :members, :status, :string
    add_column :members, :on_massacre, :boolean
    add_column :members, :on_travel_team, :boolean
    add_column :members, :league_job, :string
    add_column :members, :purchased_wftda_insurance, :boolean
    add_column :members, :passed_wftda_test, :boolean
    add_column :members, :google_doc_access, :boolean
    add_column :members, :official, :boolean
    add_column :members, :wftda_certification, :integer
    add_column :members, :skating_official, :boolean

    remove_column :members, :legal_name
  end
end

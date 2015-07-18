# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150718022252) do

  create_table "members", force: :cascade do |t|
    t.string   "derby_name"
    t.string   "email_address"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "legal_name_first"
    t.string   "legal_name_last"
    t.string   "number"
    t.string   "wftda_number"
    t.string   "nickname"
    t.string   "group"
    t.boolean  "signed_wftda_waiver"
    t.boolean  "signed_wftda_confidentiality"
    t.boolean  "signed_league_bylaws"
    t.integer  "wftda_id"
    t.string   "forum_name"
    t.integer  "year_joined"
    t.integer  "year_left"
    t.string   "reason_left"
    t.string   "phone_number"
    t.string   "emergency_contact_name_first"
    t.string   "emergency_contact_name_last"
    t.string   "emergency_contact_phone"
    t.string   "emergency_contact_relation"
    t.date     "date_of_birth"
    t.string   "address_state"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_zip"
    t.string   "primary_insurance"
    t.string   "status"
    t.boolean  "on_massacre"
    t.boolean  "on_travel_team"
    t.string   "league_job"
    t.boolean  "purchased_wftda_insurance"
    t.boolean  "passed_wftda_test"
    t.boolean  "google_doc_access"
    t.boolean  "official"
    t.integer  "wftda_certification"
    t.boolean  "skating_official"
  end

end

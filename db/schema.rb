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

ActiveRecord::Schema.define(version: 20160803132652) do

  create_table "committee_members", force: :cascade do |t|
    t.integer  "committee_id", null: false
    t.integer  "member_id",    null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "committee_members", ["committee_id", "member_id"], name: "index_committee_members_on_committee_id_and_member_id", unique: true
  add_index "committee_members", ["committee_id"], name: "index_committee_members_on_committee_id"
  add_index "committee_members", ["member_id"], name: "index_committee_members_on_member_id"

  create_table "committees", force: :cascade do |t|
    t.integer  "pillar_id",  null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "committees", ["pillar_id"], name: "index_committees_on_pillar_id"

  create_table "emergency_contacts", force: :cascade do |t|
    t.integer  "member_id",    null: false
    t.string   "name",         null: false
    t.string   "phone_number", null: false
    t.text     "address"
    t.string   "relationship"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "emergency_contacts", ["member_id"], name: "index_emergency_contacts_on_member_id"

  create_table "jobs", force: :cascade do |t|
    t.integer  "committee_id",         null: false
    t.string   "name",                 null: false
    t.boolean  "is_full_time"
    t.integer  "hours_per_week_lower"
    t.date     "date_started"
    t.date     "date_ended"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "hours_per_week_upper"
  end

  add_index "jobs", ["committee_id"], name: "index_jobs_on_committee_id"

  create_table "member_jobs", force: :cascade do |t|
    t.integer  "member_id",    null: false
    t.integer  "job_id",       null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "member_jobs", ["job_id"], name: "index_member_jobs_on_job_id"
  add_index "member_jobs", ["member_id", "job_id"], name: "index_member_jobs_on_member_id_and_job_id", unique: true
  add_index "member_jobs", ["member_id"], name: "index_member_jobs_on_member_id"

  create_table "members", force: :cascade do |t|
    t.string   "street_name",                  null: false
    t.string   "nickname",                     null: false
    t.string   "phone_number"
    t.string   "forum_handle"
    t.text     "address"
    t.date     "date_of_birth"
    t.string   "wftda_id_number"
    t.string   "primary_insurance"
    t.boolean  "signed_wftda_waiver"
    t.boolean  "signed_wftda_confidentiality"
    t.boolean  "signed_league_bylaws"
    t.boolean  "purchased_wftda_insurance"
    t.boolean  "passed_wftda_test"
    t.boolean  "active"
    t.boolean  "google_doc_access"
    t.integer  "year_joined"
    t.integer  "year_left"
    t.text     "reason_left"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "government_name",              null: false
    t.boolean  "official"
    t.boolean  "volunteer"
    t.string   "pronouns"
    t.string   "email_address"
  end

  create_table "pillars", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "name",         null: false
    t.string   "number",       null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "active"
    t.integer  "team_id"
  end

  add_index "players", ["member_id"], name: "index_players_on_member_id"
  add_index "players", ["name", "number", "team_id"], name: "index_players_on_name_and_number_and_team_id", unique: true

  create_table "teams", force: :cascade do |t|
    t.string   "name",         null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end

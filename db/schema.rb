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

ActiveRecord::Schema.define(version: 20170930190452) do

  create_table "candidates", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 70, null: false
    t.string "address", limit: 100
    t.string "city", limit: 50
    t.string "state", limit: 2
    t.string "zip", limit: 5
    t.string "title", limit: 100
    t.text "description"
    t.string "minimum_salary", limit: 7
    t.string "linkedin", limit: 50
    t.string "github", limit: 50
    t.boolean "is_active", default: true
    t.boolean "can_relocate", default: true
    t.boolean "can_remote", default: true
    t.boolean "is_visa_needed", default: true
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_candidates_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 50, null: false
    t.string "password", limit: 50, null: false
    t.integer "profile_id", null: false
    t.string "profile_type", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_users_on_profile_id"
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_11_112851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.integer "new_contributor_id", null: false
    t.integer "last_updater_id"
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id", null: false
    t.text "photo"
    t.date "event_date", default: -> { "now()" }, null: false
    t.boolean "email_notice", default: true, null: false
    t.index ["group_id"], name: "index_diaries_on_group_id"
    t.index ["last_updater_id"], name: "index_diaries_on_last_updater_id"
    t.index ["new_contributor_id"], name: "index_diaries_on_new_contributor_id"
  end

  create_table "groupings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_groupings_on_group_id"
    t.index ["user_id", "group_id"], name: "index_groupings_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_groupings_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "explanation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "delivery_start_year"
    t.integer "receiving_date", default: 0, null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "maps", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.time "event_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "diary_id", null: false
    t.bigint "group_id", null: false
    t.index ["diary_id"], name: "index_maps_on_diary_id"
    t.index ["group_id"], name: "index_maps_on_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diaries", "groups"
  add_foreign_key "groupings", "groups"
  add_foreign_key "groupings", "users"
  add_foreign_key "maps", "diaries"
  add_foreign_key "maps", "groups"
end

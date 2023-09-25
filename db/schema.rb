# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_25_111431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "houses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "area"
    t.integer "number_of_rooms"
    t.text "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "house_id", null: false
    t.date "booking_date"
    t.date "checkout_date"
    t.decimal "total_charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_reservations_on_house_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "username"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "houses", "users"
  add_foreign_key "reservations", "houses"
  add_foreign_key "reservations", "users"
end

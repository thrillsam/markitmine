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

<<<<<<< Updated upstream
ActiveRecord::Schema.define(version: 20180524151054) do
=======
ActiveRecord::Schema.define(version: 20180524134218) do
>>>>>>> Stashed changes

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "copyrights", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "date"
<<<<<<< Updated upstream
    t.string "type_of_file"
    t.index ["user_id"], name: "index_copyrights_on_user_id"
    t.string "photo_url"
    t.bigint "user_id"
    t.datetime "date"
    t.string "type"
    t.string "source"
    t.datetime "uploaded_date"
    t.string "uploaded_id"
    t.integer "likes_count"
    t.string "tags"
=======
    t.string "photo_url"
    t.string "type"
>>>>>>> Stashed changes
    t.index ["user_id"], name: "index_copyrights_on_user_id"
  end

  create_table "device_configs", force: :cascade do |t|
    t.integer "os"
    t.string "device_type"
    t.string "device_uuid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_auth_token"
    t.index ["user_id"], name: "index_device_configs_on_user_id"
  end

  create_table "instagram_users", force: :cascade do |t|
    t.integer "user_id"
    t.string "access_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "contact_number"
    t.string "password"
    t.string "password_digest"
    t.string "password_confirmation"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "copyrights", "users"
  add_foreign_key "device_configs", "users"
end

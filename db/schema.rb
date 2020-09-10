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

ActiveRecord::Schema.define(version: 2020_09_10_205612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "symptom_id"
    t.string "time"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symptom_id"], name: "index_logs_on_symptom_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "brand_name"
    t.string "generic_name"
    t.string "med_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.string "access_token"
    t.string "refresh_token"
    t.string "first_name"
    t.string "last_name"
    t.string "birthdate"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "logs", "symptoms"
  add_foreign_key "logs", "users"
end

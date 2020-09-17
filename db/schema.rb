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

ActiveRecord::Schema.define(version: 2020_09_17_170726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "symptom_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "when"
    t.index ["symptom_id"], name: "index_logs_on_symptom_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "medication_symptoms", force: :cascade do |t|
    t.bigint "medication_id"
    t.bigint "symptom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medication_id"], name: "index_medication_symptoms_on_medication_id"
    t.index ["symptom_id"], name: "index_medication_symptoms_on_symptom_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "brand_name"
    t.string "generic_name"
    t.string "product_ndc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_ndc"], name: "index_medications_on_product_ndc", unique: true
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_medications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "medication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medication_id"], name: "index_user_medications_on_medication_id"
    t.index ["user_id"], name: "index_user_medications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.string "access_token"
    t.string "first_name"
    t.string "last_name"
    t.string "birthdate"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "logs", "symptoms"
  add_foreign_key "logs", "users"
  add_foreign_key "medication_symptoms", "medications"
  add_foreign_key "medication_symptoms", "symptoms"
  add_foreign_key "user_medications", "medications"
  add_foreign_key "user_medications", "users"
end

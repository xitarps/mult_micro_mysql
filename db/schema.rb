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

ActiveRecord::Schema[7.1].define(version: 2024_10_15_053450) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leadership_levels", force: :cascade do |t|
    t.integer "level", default: 0, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_leadership_levels_on_company_id"
    t.index ["level", "company_id"], name: "index_leadership_levels_on_level_and_company_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "level"
    t.bigint "leadership_level_id"
    t.bigint "company_id", null: false
    t.string "name"
    t.string "email"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email", "company_id"], name: "index_users_on_email_and_company_id", unique: true
    t.index ["leadership_level_id"], name: "index_users_on_leadership_level_id"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  add_foreign_key "leadership_levels", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "leadership_levels"
  add_foreign_key "users", "users"
end

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

ActiveRecord::Schema[8.0].define(version: 2025_03_12_142351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bets", force: :cascade do |t|
    t.bigint "odd_id", null: false
    t.bigint "user_id", null: false
    t.decimal "stake", precision: 8, scale: 2, null: false
    t.decimal "payout", precision: 8, scale: 2, null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["odd_id"], name: "index_bets_on_odd_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "competitions", force: :cascade do |t|
    t.string "key"
    t.string "group"
    t.string "title"
    t.string "description"
    t.boolean "active"
    t.boolean "has_outrights"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", id: :string, force: :cascade do |t|
    t.datetime "commence_time"
    t.string "home_team", null: false
    t.string "away_team", null: false
    t.string "status", default: "pending", null: false
    t.bigint "competition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_events_on_competition_id"
  end

  create_table "odds", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.string "status", default: "pending", null: false
    t.string "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.string "name", null: false
    t.integer "result"
    t.string "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "coins"
    t.decimal "dimaonds"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "bets", "odds"
  add_foreign_key "bets", "users"
  add_foreign_key "events", "competitions"
  add_foreign_key "odds", "events"
  add_foreign_key "scores", "events"
  add_foreign_key "wallets", "users"
end

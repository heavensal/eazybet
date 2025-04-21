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

ActiveRecord::Schema[8.0].define(version: 2025_04_18_184632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ads", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "video"
    t.boolean "active", default: false, null: false
    t.integer "views_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "odd_id", null: false
    t.bigint "user_id", null: false
    t.decimal "stake", precision: 8, scale: 2, null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "money_type", default: "coins", null: false
    t.decimal "coins_to_win", precision: 8, scale: 2, null: false
    t.decimal "diamonds_to_win", precision: 10, scale: 4, null: false
    t.decimal "odd_price", precision: 8, scale: 2, null: false
    t.index ["odd_id", "user_id"], name: "index_bets_on_odd_id_and_user_id", unique: true
    t.index ["odd_id"], name: "index_bets_on_odd_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.string "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
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

  create_table "followers", force: :cascade do |t|
    t.boolean "instagram"
    t.boolean "telegram"
    t.boolean "x_twitter"
    t.boolean "youtube"
    t.boolean "tiktok"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_friendships_on_receiver_id"
    t.index ["sender_id", "receiver_id"], name: "index_friendships_on_sender_id_and_receiver_id", unique: true
    t.index ["sender_id"], name: "index_friendships_on_sender_id"
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

  create_table "teams", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "odd_api_id", null: false
    t.string "short_name"
    t.string "english_name"
    t.string "french_name"
    t.string "spanish_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.bigint "referrer_id"
    t.string "referral_token"
    t.string "ref_from_url"
    t.integer "daily_ads_count", default: 20, null: false
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referrer_id"], name: "index_users_on_referrer_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "coins"
    t.decimal "diamonds", precision: 10, scale: 4, default: "0.0"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "bets", "odds"
  add_foreign_key "bets", "users"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "competitions"
  add_foreign_key "followers", "users"
  add_foreign_key "friendships", "users", column: "receiver_id"
  add_foreign_key "friendships", "users", column: "sender_id"
  add_foreign_key "odds", "events"
  add_foreign_key "scores", "events"
  add_foreign_key "users", "users", column: "referrer_id"
  add_foreign_key "wallets", "users"
end

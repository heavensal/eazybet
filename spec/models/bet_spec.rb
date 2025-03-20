require 'rails_helper'

RSpec.describe Bet, type: :model do
  let(:user) { User.create(email: "test@gmail.com", password: "123456", first_name: "Test", last_name: "User", phone_number: "1234567890", role: "user") }

  let(:wallet) { Wallet.create(coins: 1000, user: user, diamonds: 0) }

  let(:competition) { Competition.create(key: "premier_league", group: "England", title: "Premier League", description: "The Premier League, often referred to as the English Premier League or the EPL outside England, is the top level of the English football league system.", active: true, has_outrights: true) }

  let(:event) { Event.create(id: "blablablaidevent", commence_time: Time.now + 1.day, home_team: "Arsenal", away_team: "Chelsea", status: "pending", competition: competition) }

  let(:odd) { Odd.create(name: "Arsenal", price: 1.5, status: "pending", event: event) }
  let(:odd2) { Odd.create(name: "Chelsea", price: 2.5, status: "pending", event: event) }
  let(:odd3) { Odd.create(name: "Draw", price: 3.5, status: "pending", event: event) }

  it "cannot be created if the user doesn't have enough coins" do
    bet = Bet.new(odd: odd, user: user, stake: 1001, payout: 1501, status: "pending")
    expect(bet).not_to be_valid
  end
end


# create_table "competitions", force: :cascade do |t|
#   t.string "key"
#   t.string "group"
#   t.string "title"
#   t.string "description"
#   t.boolean "active"
#   t.boolean "has_outrights"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
#
# create_table "events", id: :string, force: :cascade do |t|
#   t.datetime "commence_time"
#   t.string "home_team", null: false
#   t.string "away_team", null: false
#   t.string "status", default: "pending", null: false
#   t.bigint "competition_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["competition_id"], name: "index_events_on_competition_id"
# end
#
# create_table "odds", force: :cascade do |t|
# t.string "name", null: false
# t.decimal "price", precision: 8, scale: 2, null: false
# t.string "status", default: "pending", null: false
# t.string "event_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# end

# create_table "wallets", force: :cascade do |t|
#   t.decimal "coins"
#   t.decimal "diamonds", precision: 8, scale: 2, default: "0.0"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_wallets_on_user_id"
# end

# create_table "bets", force: :cascade do |t|
#   t.bigint "odd_id", null: false
#   t.bigint "user_id", null: false
#   t.decimal "stake", precision: 8, scale: 2, null: false
#   t.decimal "payout", precision: 8, scale: 2, null: false
#   t.string "status"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["odd_id"], name: "index_bets_on_odd_id"
#   t.index ["user_id"], name: "index_bets_on_user_id"
# end

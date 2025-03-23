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
#

FactoryBot.define do
  factory :bet do
    association :odd
    association :user
    stake { 10.0 }
    status { "pending" }

    trait :won do
      status { "won" }
    end

    trait :lost do
      status { "lost" }
    end
  end
end

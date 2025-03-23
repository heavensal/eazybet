# create_table "odds", force: :cascade do |t|
#   t.string "name", null: false
#   t.decimal "price", precision: 8, scale: 2, null: false
#   t.string "status", default: "pending", null: false
#   t.string "event_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

FactoryBot.define do
  factory :odd do
    name { "Home Team 1" }
    price { rand(1.0..10.0).round(2) }
    status { "pending" }
    association :event

    trait :won do
      status { "won" }
    end

    trait :lost do
      status { "lost" }
    end
  end
end

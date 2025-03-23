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
#
FactoryBot.define do
  factory :event do
    id { SecureRandom.uuid }
    commence_time { Time.now + 1.day }
    home_team { "Home Team 1" }
    away_team { "Away Team 1" }
    status { "pending" }
    association :competition

    trait :live do
      commence_time { Time.now - 1.hour }
      status { "live" }
    end

    trait :finished do
      commence_time { Time.now - 1.day }
      status { "finished" }
    end

    trait :cancelled do
      commence_time { Time.now + 1.day }
      status { "cancelled" }
    end
  end
end

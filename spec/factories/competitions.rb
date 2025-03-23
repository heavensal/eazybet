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

FactoryBot.define do
  factory :competition do
    key { "epl" }
    group { "English Premier League" }
    title { "English Premier League" }
    description { "English Premier League" }
    active { true }
    has_outrights { true }
  end
end

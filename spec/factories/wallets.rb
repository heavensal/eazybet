# create_table "wallets", force: :cascade do |t|
#   t.decimal "coins"
#   t.decimal "diamonds", precision: 8, scale: 2, default: "0.0"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_wallets_on_user_id"
# end

FactoryBot.define do
  factory :wallet do
    association :user
    coins { 1000 }
    diamonds { 0.0 }
  end
end

FactoryBot.define do
  factory :user do
    email { "adamistesting@test.fr" }
    password { "password123" }
    password_confirmation { "password123" }
    first_name { "Adam" }
    last_name { "Smith" }
    phone_number { "1234567890" }
    role { "user" }
    confirmed_at { Time.now }

    trait :admin do
      role { "admin" }
    end
  end
end

# create_table "users", force: :cascade do |t|
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "first_name"
#   t.string "last_name"
#   t.string "phone_number"
#   t.string "role", default: "user", null: false
#   t.string "confirmation_token"
#   t.datetime "confirmed_at"
#   t.datetime "confirmation_sent_at"
#   t.string "unconfirmed_email"
#   t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end

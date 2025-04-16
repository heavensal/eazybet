FactoryBot.define do
  factory :ad do
    title { "MyString" }
    description { "MyText" }
    video { "MyString" }
    active { false }
    views_count { 1 }
  end
end

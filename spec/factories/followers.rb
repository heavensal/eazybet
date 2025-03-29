FactoryBot.define do
  factory :follower do
    instagram { false }
    telegram { false }
    x_twitter { false }
    youtube { false }
    tiktok { false }
    user { nil }
  end
end

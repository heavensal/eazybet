class Wallet < ApplicationRecord
  belongs_to :user

  validates :coins, numericality: { greater_than_or_equal_to: 0 }
  validates :diamonds, numericality: { greater_than_or_equal_to: 0 }

  after_create :reward_referral


  def reward_referral
    return unless user.referrer
    update!(diamonds: diamonds + 5)
    user.referrer.wallet.update!(diamonds: user.referrer.wallet.diamonds + 5)
  end
end

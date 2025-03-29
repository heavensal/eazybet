class Follower < ApplicationRecord
  belongs_to :user

  validates :instagram, :telegram, :x_twitter, :youtube, :tiktok, inclusion: { in: [ true, false ] }

  # Callback avant update
  before_update :update_user_coins_if_changed

  private

  def update_user_coins_if_changed
    %i[instagram telegram x_twitter youtube tiktok].each do |field|
      if saved_change_to_attribute?(field)
        if self[field] # si devient true
          user.wallet.increment!(:coins, 1000)
        else # si devient false
          user.wallet.decrement!(:coins, 1000)
        end
      end
    end
  end
end

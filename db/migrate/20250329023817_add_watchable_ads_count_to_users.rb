class AddWatchableAdsCountToUsers < ActiveRecord::Migration[8.0]
  def change
    # strictly more or equal to 0
    add_column :users, :daily_ads_count, :integer, default: 20, null: false
  end
end

class AddReferrerToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :referrer, foreign_key: { to_table: :users }, null: true
    add_column :users, :referral_token, :string
  end
end

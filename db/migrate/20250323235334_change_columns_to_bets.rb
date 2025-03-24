class ChangeColumnsToBets < ActiveRecord::Migration[8.0]
  def change
    add_column :bets, :money_type, :string, default: "coins", null: false
    add_column :bets, :coins_to_win, :decimal, precision: 8, scale: 2, null: false
    add_column :bets, :diamonds_to_win, :decimal, precision: 8, scale: 2, null: false
    add_column :bets, :odd_price, :decimal, precision: 8, scale: 2, null: false

    # supprimer la column payout
    remove_column :bets, :payout
  end

  # le combo odd_id + user_id doit être unique
  add_index :bets, [ :odd_id, :user_id ], unique: true
end

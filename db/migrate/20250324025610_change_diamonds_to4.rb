class ChangeDiamondsTo4 < ActiveRecord::Migration[8.0]
  def change
    change_column :wallets, :diamonds, :decimal, precision: 10, scale: 4
    change_column :bets, :diamonds_to_win, :decimal, precision: 10, scale: 4
  end
end

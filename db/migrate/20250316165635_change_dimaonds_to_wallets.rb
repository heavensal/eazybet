class ChangeDimaondsToWallets < ActiveRecord::Migration[8.0]
  def change
    rename_column :wallets, :dimaonds, :diamonds
    change_column :wallets, :diamonds, :decimal, precision: 8, scale: 2, default: 0
  end
end

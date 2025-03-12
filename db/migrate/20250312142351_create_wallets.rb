class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets do |t|
      t.decimal :coins, precision: 8, scale: 2
      t.decimal :diamonds, precision: 8, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

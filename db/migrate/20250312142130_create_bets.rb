class CreateBets < ActiveRecord::Migration[8.0]
  def change
    create_table :bets do |t|
      t.references :odd, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :stake, null: false, precision: 8, scale: 2
      t.decimal :payout, null: false, precision: 8, scale: 2
      t.string :status

      t.timestamps
    end
  end
end

class CreateOdds < ActiveRecord::Migration[8.0]
  def change
    create_table :odds do |t|
      t.string :name, null: false
      t.decimal :price, null: false, precision: 8, scale: 2
      t.string :status, default: "pending", null: false
      t.string :event_id, null: false

      t.timestamps
    end

    add_foreign_key :odds, :events, column: :event_id, primary_key: :id
  end
end

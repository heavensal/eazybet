class CreateFriendships < ActiveRecord::Migration[8.0]
  def change
    create_table :friendships do |t|
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.string :status, null: false, default: "pending"

      t.timestamps
    end

    add_index :friendships, [ :sender_id, :receiver_id ], unique: true
  end
end

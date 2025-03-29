class CreateFollowers < ActiveRecord::Migration[8.0]
  def change
    create_table :followers do |t|
      t.boolean :instagram, default: false, null: false
      t.boolean :telegram, default: false, null: false
      t.boolean :x_twitter, default: false, null: false
      t.boolean :youtube, default: false, null: false
      t.boolean :tiktok, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

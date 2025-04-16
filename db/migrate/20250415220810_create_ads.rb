class CreateAds < ActiveRecord::Migration[8.0]
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.text :description
      t.string :video
      t.boolean :active, default: false, null: false
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end

class CreateScores < ActiveRecord::Migration[8.0]
  def change
    create_table :scores do |t|
      t.string :name, null: false
      t.integer :result
      t.string :event_id, null: false

      t.timestamps
    end

    add_foreign_key :scores, :events, column: :event_id, primary_key: :id
  end
end

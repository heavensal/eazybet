class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: false do |t|
      t.string :id, primary_key: true
      t.datetime :commence_time
      t.string :home_team, null: false
      t.string :away_team, null: false
      t.string :status, default: "pending", null: false
      t.references :competition, null: false, foreign_key: true

      t.timestamps
    end
  end
end

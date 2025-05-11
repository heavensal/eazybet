class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :full_name, null: false
      t.string :odd_api_id, null: false
      t.string :short_name
      t.string :english_name
      t.string :french_name
      t.string :spanish_name

      t.timestamps
    end
  end
end

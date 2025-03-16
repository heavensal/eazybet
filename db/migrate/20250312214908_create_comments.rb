class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.string :event_id, null: false

      t.timestamps
    end

    add_foreign_key :comments, :events, column: :event_id, primary_key: :id
  end
end
